//
//  GameView.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 07/02/24.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel: GameViewModel = GameViewModel()
    
    @Binding var isShow: Bool
        
    var body: some View {
        ZStack {
            ZStack {
                createBackground()
                
                createBackButton()
                
                VStack {
                    createTitle()
                    
                    createTextInformation()
                    
                    createTextInstruction()
                }

                createEmptyRandomMaskContainers()
                
                if viewModel.isAllRevealed {
                    createButtonReturnToMainView()
                }
                
                createDraggableMasks()
            }
            .blur(radius: viewModel.isShowCongratulationPopup || viewModel.isShowIncorrectPlacePopup ? 5 : 0)
            .overlay {
                if viewModel.isShowCongratulationPopup {
                    showCongratulationPopup()
                } else if viewModel.isShowIncorrectPlacePopup {
                    showIncorrectPlacePopup()
                }
            }
            .onAppear {
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 1,
                                               based: $viewModel.isMasksOnScreen)
            }
            .onChange(of: viewModel.isAllRevealed) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        viewModel.isShowCongratulationPopup = true
                    }
                }
            }
            
            if viewModel.isReturnedToMainView {
                MainView()
            }
        }
    }
    
    
    @ViewBuilder private func createBackground() -> some View {
        BackgroundView(isRemoveFromScreen: .constant(false))
    }
    
    
    @ViewBuilder private func createBackButton() -> some View {
        Button {
            isShow = false
        } label: {
            Image(systemName: "arrowshape.turn.up.backward")
                .foregroundStyle(.yellow)
                .scaleEffect(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .shadow(color: .yellow, radius: 5)
        }
        .offset(x: viewModel.isMasksOnScreen ? 0 : -200)

    }
    
    
    @ViewBuilder private func createTitle() -> some View {
        TitleView(text: "Guess & Place")
            .padding(.bottom, 50)
            .offset(.setOffset(fromY: -600, based: viewModel.isTitleOnScreen))
            .onAppear {
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 1,
                                               based: $viewModel.isTitleOnScreen)
            }
    }
    
    
    @ViewBuilder private func createTextInformation() -> some View {
        Text("Panca Wanda is also commonly\nused as home decoration in Cirebon")
            .font(.system(size: 22.5, weight: .semibold, design: .serif))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .frame(width: 400)
            .padding(.bottom)
            .opacity(viewModel.isMasksOnScreen ? 1 : 0)
    }
    
    
    @ViewBuilder private func createTextInstruction() -> some View {
        Text("Now, let's try to place them in the right place based on the clues")
            .font(.system(size: 20, weight: .semibold, design: .serif))
            .foregroundStyle(Color("customSecondary"))
            .padding(.top)
            .opacity(viewModel.isMasksOnScreen ? 1 : 0)
            .opacity(viewModel.isAllRevealed ? 0 : 1)

        Spacer()
    }
    
    
    @ViewBuilder private func createEmptyRandomMaskContainers() -> some View {
        ZStack {
            Text("Drag and drop masks below on an empty container. Tap each mask to get the clues.")
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundStyle(Color("customSecondary"))
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .opacity(viewModel.isAllRevealed ? 0 : 1)
            
            ForEach(viewModel.randomMasks.indices, id: \.self) { index in
                PlaceholderView(mask: viewModel.randomMasks[index],
                                  isRevealed: viewModel.revealingFor(index),
                                  isTapped: viewModel.tappingFor(index))
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                viewModel.containerMaskFrames[index] = geo.frame(in: .global)
                            }
                    }
                }
                .offset(viewModel.offsetForIndex(index))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .offset(y: 115)
        .opacity(viewModel.isMasksOnScreen ? 1 : 0)
    }

    
    @ViewBuilder private func createDraggableMasks() -> some View {
        HStack {
            ForEach(viewModel.masks.indices, id: \.self) { index in
                DraggableMask(mask: viewModel.masks[index],
                              onChanged: viewModel.maskMoved,
                              onEnded: viewModel.maskDropped)
            }
        }
        .padding(.horizontal, 10)
        .background {
            LinearGradient(colors: [
                Color("customRedTop").opacity(0.95),
                Color("customRedTop").opacity(0.85),
                Color("customRedBottom").opacity(0.75)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .background {
                Image("background-batik")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 5)
                    .foregroundStyle(.yellow)
                    .shadow(color: .yellow, radius: 5)
            }
            .allowsHitTesting(false)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(y: viewModel.isMasksOnScreen ? 0 : 300)
    }
    
    
    @ViewBuilder private func createButtonReturnToMainView() -> some View {
        Button {
            viewModel.audioPlayer.stopMusic()
            withAnimation {
                viewModel.isReturnedToMainView = true
            }
        } label: {
            RoundedRectangle(cornerRadius: 60)
                .stroke(lineWidth: 5)
                .fill(.yellow)
                .overlay {
                    Image(systemName: "house")
                        .imageScale(.large)
                        .bold()
                        .foregroundStyle(.yellow)
                }
                .frame(width: 100, height: 44)
                .shadow(color: .yellow, radius: 5)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 140)
    }
    
    
    @ViewBuilder private func showCongratulationPopup() -> some View {
        PopupView(title: "Congrats!", 
                  description: "You've learned about one of Indonesia's cultural heritage.\n\nI hope you could understand the message behind the mask and apply its moral lesson in your life!",
                  isShowDismissButton: $viewModel.isShowCongratulationPopup)
    }
    
    @ViewBuilder private func showIncorrectPlacePopup() -> some View {
        PopupView(title: "Incorrect Place",
                  description:  "Oops! It seems like you've misplaced the mask. Please check the clues and try again.\n\nIf you got no clue, feel free to go back to the previous section.",
                  isShowDismissButton: $viewModel.isShowIncorrectPlacePopup)
    }
}

#Preview {
    GameView(isShow: .constant(true))
}


