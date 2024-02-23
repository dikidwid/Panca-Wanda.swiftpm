import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            ZStack {
                createBackground()
                
                createTextTitles()
                
                createMasks()
                
                createTextTapAnywhere()
            }
            .onAppear {
                viewModel.audioPlayer.playMusic()
            }
            .disabled(viewModel.showIntroductionScreen)
            .onTapGesture {
                withAnimation(
                    .interpolatingSpring(duration: 1)
                    .speed(0.5)
                ) {
                    viewModel.isRemoveBackground = true
                    viewModel.isTapAnywhereAnimate = false
                    viewModel.isTitleOnScreen = false
                    viewModel.animationManager.set(animationType: .interpolatingSpring,
                                                   duration: 1,
                                                   speed: 0.5,
                                                   delay: 2,
                                                   based: $viewModel.isMasksOnScreen)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    viewModel.showIntroductionScreen = true
                }
                
            }
            if viewModel.showIntroductionScreen {
                IntroductionView()
            }
        }
        
    }
    
    
    @ViewBuilder private func createBackground() -> some View {
        BackgroundView(isMainViewBackground: true, isRemoveFromScreen: $viewModel.isRemoveBackground)
    }
    
    
    @ViewBuilder private func createTextTitles() -> some View {
        VStack(spacing: 20) {
            
            TitleView(text: "PANCA\nWANDA", isMainView: true)
            
            Text("Cirebon Mask Dance")
                .font(.system(size: 25, weight: .semibold, design: .serif))
                .foregroundStyle(.white)
        }
        .offset(y: viewModel.isTitleOnScreen ? 0 : -350)
        .frame(maxHeight: .infinity, alignment: .top)
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
                MaskImageView(mask: viewModel.masks[index])
                    .offset(viewModel.inTransitionFor(index))
                    .offset(viewModel.setMaskOffsetFor(index))
                    .rotationEffect(viewModel.rotationEffectFor(index))
                    .onAppear {
                        viewModel.animationManager.set(animationType: .interpolatingSpring,
                                                       duration: 1,
                                                       speed: 0.5,
                                                       delay: 0,
                                                       based: $viewModel.isMasksOnScreen)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(viewModel.setMaskAnimationFor(index)) {
                                viewModel.setAnimationValueFor(index).wrappedValue.toggle()
                            }
                        }
                    }
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.top, 50)
    }
    
    
    @ViewBuilder private func createTextTapAnywhere() -> some View {
        Text("Tap anywhere to start")
            .font(.system(size: 30, weight: .bold, design: .serif))
            .foregroundStyle(.white)
            .padding(.top, 30)
            .opacity(viewModel.isTapAnywhereAnimate ? 1 : 0)
            .onAppear {
                viewModel.animationManager.set(animationType: .linear,
                                               duration: 0.5,
                                               speed: 0.5,
                                               delay: 2,
                                               repeatForever: true,
                                               based: $viewModel.isTapAnywhereAnimate)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 200)
    }
}
