//
//  TitleView.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 07/02/24.
//

import SwiftUI

struct IntroductionView: View {
    
    @StateObject var viewModel: IntroductionViewModel = IntroductionViewModel()
    
    var body: some View {
        ZStack {
            ZStack {
                createBackground()
                
                createTitle()
                
                VStack {
                    createMasks()
                    
                    createTextDescription()
                    
                    createTextTapToContinue()
                }
            }
            .onTapGesture {
                viewModel.tapCount += 1
            }
            .onChange(of: viewModel.tapCount) { _ in
               handleTapCount()
            }
            if viewModel.showExplorationView {
                ExplorationView()
            }
        }
    }
    
    
    private func handleTapCount() {
        if viewModel.tapCount == 1 {
            withAnimation {
                viewModel.descriptionTextType = .second
            }
        }
        else if viewModel.tapCount == 2 {
            withAnimation {
                viewModel.descriptionTextType = .third
            }
            viewModel.animationManager.set(animationType: .interpolatingSpring, duration: 5, speed: 1, delay: 0, based: $viewModel.isShowMasksName)
        } else if viewModel.tapCount >= 3 {
            withAnimation(
                .linear(duration: 1)
                .speed(0.5)
            ){
                viewModel.isTapToContinueAnimate = false
                viewModel.isDescriptionOnScreen = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(
                    .interpolatingSpring(duration: 1)
                    .speed(0.5)
                ) {
                    viewModel.isShowMasksName = false
                    viewModel.isTitleOnScreen = false
                    viewModel.isRemoveBackground = true
                    
                }
                viewModel.animationManager.set(animationType: .interpolatingSpring,
                                               duration: 1,
                                               speed: 0.5,
                                               delay: 2,
                                               based: $viewModel.isMasksOutScreen)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                viewModel.showExplorationView = true
                
            }
        }
    }
    
    
    @ViewBuilder private func createBackground() -> some View {
        BackgroundView(isRemoveFromScreen: $viewModel.isRemoveBackground)
    }
    
    
    @ViewBuilder private func createTitle() -> some View {
        TitleView(text: "Introduction")
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
    
    
    @ViewBuilder private func createMasks() -> some View {
        ZStack {
            ForEach(viewModel.masks.indices, id: \.self) { index in
                MaskImageView(mask: viewModel.masks[index], isUsedName: viewModel.isShowMasksName)
                    .offset(viewModel.setMaskNameOffsetFor(index))
                    .offset(viewModel.inTransitionFor(index))
                    .offset(viewModel.setMaskOffsetFor(index))
                    .rotationEffect(viewModel.rotationEffectFor(index))
                    .onAppear {
                        viewModel.animationManager.set(animationType: .interpolatingSpring,
                                                       duration: 1,
                                                       speed: 0.5,
                                                       delay: 2,
                                                       based: $viewModel.isMasksOnScreen)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(viewModel.maskAnimationFor(index)) {
                                viewModel.animationValueFor(index).wrappedValue.toggle()
                            }
                        }
                    }
            }
        }
        .padding(.top, 140)
        .padding(.bottom, 100)
        .offset(y: viewModel.isMasksOutScreen ? -800 : 0)
    }
    
    
    @ViewBuilder private func createTextDescription() -> some View {
        Group {
            Text("Panca Wanda")
                .font(.system(size: viewModel.isShowMasksName ? 25 : 27.5, weight: .bold, design: .serif))
            
            +
            
            Text(viewModel.descriptionTextType.text)
                .font(.system(size: viewModel.isShowMasksName ? 22.5 : 25, weight: .regular, design: .serif))
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .animation(.smooth, value: viewModel.isShowMasksName)
        .opacity(viewModel.isDescriptionOnScreen ? 1 : 0)
        .padding(.horizontal, 150)
        .padding(.top, 60)
        .offset(y: viewModel.isShowMasksName ? 170 : 0)
        .shadow(color: .black.opacity(0.25), radius: 5)

        .onAppear {
            viewModel.animationManager.set(animationType: .linear, 
                                           duration: 1,
                                           speed: 0.5,
                                           delay: 4,
                                           based: $viewModel.isDescriptionOnScreen)
        }
    }
    
    
    @ViewBuilder private func createTextTapToContinue() -> some View {
        Text("Tap to continue")
            .font(.system(size: 30, weight: .bold, design: .serif))
            .foregroundStyle(.white)
            .padding(.top, 50)
            .offset(y: viewModel.isShowMasksName ? -455 : 0)
            .opacity(viewModel.isTapToContinueAnimate ? 1 : 0)
            .onAppear {
                viewModel.animationManager.set(animationType: .linear,
                                               duration: 0.5,
                                               speed: 0.5,
                                               delay: 5.5,
                                               repeatForever: true,
                                               based: $viewModel.isTapToContinueAnimate)
            }
    }
}

#Preview {
    IntroductionView()
}
