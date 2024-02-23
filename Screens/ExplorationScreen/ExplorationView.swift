//
//  ExplorationView.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 07/02/24.
//

import SwiftUI

struct ExplorationView: View {
    
    @StateObject var viewModel: ExplorationViewModel = ExplorationViewModel()
        
    var body: some View {
        ZStack {
            createBackground()
            
            createTitle()
            
            createTapableMasks()
            
            if viewModel.isAllMaskTapped {
                createButtonToNextScreen()
            } else {
                createButtonInstruction()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                withAnimation {
                    viewModel.isShowPopup = true
                }
            }
        }
        .blur(radius: viewModel.isShowPopup || viewModel.isShowDetailMask ? 5 : 0)
        .overlay(alignment: .center) {
            if viewModel.isShowPopup {
                showPopup()
            } else if viewModel.isShowDetailMask {
                showDetail()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showGameView, content: {
            GameView(isShow: $viewModel.showGameView)
        })
    }
    
    
    @ViewBuilder private func createBackground() -> some View {
        BackgroundView(isRemoveFromScreen: .constant(false))
    }
    
    
    @ViewBuilder private func createTitle() -> some View {
        TitleView(text: "Try to Explore")
            .frame(maxHeight: .infinity, alignment: .top)
            .offset(.setOffset(fromY: -600, based: viewModel.isTitleOnScreen))
            .onAppear {
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 1,
                                               based: $viewModel.isTitleOnScreen)
            }
    }
    
    
    @ViewBuilder private func createButtonToNextScreen() -> some View {
        VStack(spacing: 30) {
            Text("Great! you've explored all the masks\nAre you ready for the game?")
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundStyle(Color("customSecondary"))
                .multilineTextAlignment(.center)
                .frame(width: 350)
            
            Button {
                viewModel.showGameView = true
                
            } label: {
                RoundedRectangle(cornerRadius: 60)
                    .stroke(lineWidth: 5)
                    .fill(.yellow)
                    .overlay {
                        Text("Yes")
                            .font(.system(size: 25, weight: .semibold, design: .serif))
                            .foregroundStyle(.yellow)
                    }
                    .frame(width: 150, height: 44)
                    .shadow(color: .yellow, radius: 5)
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.top, 100)
    }
    
    
    @ViewBuilder private func createButtonInstruction() -> some View {
        VStack(spacing: 20) {
            Text("Explore the details by\nTapping on each masks")
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundStyle(Color("customSecondary"))
                .multilineTextAlignment(.center)
                .frame(width: 350)
            
            Button {
                withAnimation {
                    viewModel.isShowPopup = true
                }
            } label: {
                Image(systemName: "questionmark.circle")
                    .foregroundStyle(.yellow)
                    .imageScale(.large)
                    .scaleEffect(2)
                    .shadow(color: .yellow, radius: 5)
                    .frame(width: 50, height: 50)
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.top, 100)
        .opacity(viewModel.isInstructionsOnScreen ? 1 : 0)
        .onAppear {
            viewModel.animationManager.set(animationType: .linear, 
                                           duration: 1,
                                           speed: 0.5,
                                           delay: 2,
                                           based: $viewModel.isInstructionsOnScreen)
        }
    }
    
    
    @ViewBuilder private func createTapableMasks() -> some View {
        ForEach(viewModel.masks.indices, id: \.self) { index in
            TapableMaskView(mask: viewModel.masks[index],
                            isTapped: viewModel.tappingFor(index),
                            isShowDetailmask: $viewModel.isShowDetailMask,
                            isShowMasksName: $viewModel.isShowMasksName,
                            isMaskTapped: { viewModel.tappedMask = $0 }
            )
            .offset(viewModel.inTransitionOffsetFor(index))
            .offset(viewModel.setMaskOffsetFor(index))
            .onAppear {
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 0,
                                               based: $viewModel.isMasksOnScreen)
                
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 2,
                                               based: $viewModel.isShowMasksName)
            }
            .offset(y: viewModel.isMasksOnScreen ? 0 : -800)
        }
    }
    
    
    @ViewBuilder private func showPopup() -> some View {
        PopupView(title: "Welcome",
                  description: "Let's have some fun! Try to discover the characteristics behind each mask by simply tapping on it to reveal its story.\n\nMemorize their details. Remember what you discover because we'll be playing a fun game!",
                  isShowDismissButton: $viewModel.isShowPopup)
    }
    
    
    @ViewBuilder private func showDetail() -> some View {
        DetailMaskView(mask: viewModel.tappedMask, isShow: $viewModel.isShowDetailMask)
    }
}

#Preview {
    ExplorationView()
}
