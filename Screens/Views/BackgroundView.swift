//
//  BackgroundView.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 08/02/24.
//

import SwiftUI

struct BackgroundView: View {
    
    @State private var isLeftCloudOnScreen: Bool = false
    @State private var isRightCloudOnScreen: Bool = false
    
    @State private var isLeftSmokeOnScreen: Bool = false
    @State private var isRightSmokeOnScreen: Bool = false
    
    @State private var isLeftCloudAnimate: Bool = false
    @State private var isRightCloudAnimate: Bool = false
    
    @State private var isLeftSmokeAnimate: Bool = false
    @State private var isRightSmokeAnimate: Bool = false
    
    @Binding var isRemoveFromScreen: Bool
    
    let animationManager = AnimationManager()
        
    let isMainViewBackground: Bool
    
    init(isMainViewBackground: Bool = false, isRemoveFromScreen: Binding<Bool>) {
        self.isMainViewBackground = isMainViewBackground
        self._isRemoveFromScreen = isRemoveFromScreen
    }

    var body: some View {
        ZStack {
            createBackgroundPattern()
            
            createRedLinearGradient()
            
            createBlackRadialGradient()
            
            createTwoRedClouds()
            
            createWhiteSmokes()
        }
        .onChange(of: isRemoveFromScreen) { _ in
            clearAllComponentsFromScreen()
        }
        .ignoresSafeArea()
    }
    
    
    private func clearAllComponentsFromScreen() {
        withAnimation (
            .interpolatingSpring(duration: 1)
            .speed(0.5)
        ) {
            self.isLeftCloudOnScreen = false
            self.isRightCloudOnScreen = false
            self.isLeftSmokeOnScreen = false
            self.isRightSmokeOnScreen = false
        }
    }
    
    
    @ViewBuilder private func createBackgroundPattern() -> some View {
        Image("background-flower")
            .resizable()
    }
    
    
    @ViewBuilder func createRedLinearGradient() -> some View {
        LinearGradient(colors:
                        [Color("customRedTop"),
                         Color("customRedTop").opacity(0.85)],
                       startPoint: .top,
                       endPoint: .bottom)
    }
    
    
    @ViewBuilder func createBlackRadialGradient() -> some View {
        RadialGradient(colors: [Color.black.opacity(0), Color.black.opacity(0.35)],
                       center: .center, startRadius: 225, endRadius: 500)
    }
    
    
    @ViewBuilder func createTwoRedClouds() -> some View {
        HStack(alignment: .top) {
            Image("cloud-left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(isMainViewBackground ? 1.0 : 0.8)
                .offset(.setOffset(fromX: -350, based: isLeftCloudOnScreen))
                .offset(.setOffset(fromX: isMainViewBackground ? -195 : -160,
                                   toX: isMainViewBackground ? -180 : -170,
                                   fromY: isMainViewBackground ? 20 : -20,
                                   toY: isMainViewBackground ? 35 : -35,
                                   based: isLeftCloudAnimate))
                .onAppear {
                    animationManager.set(animationType: .interpolatingSpring,
                                         duration: 0.75,
                                         speed: 0.5,
                                         delay: 1,
                                         based: $isLeftCloudOnScreen)

                    animationManager.set(animationType: .linear,
                                         duration: 0.75,
                                         speed: 0.5,
                                         delay: 3,
                                         repeatForever: true,
                                         based: $isLeftCloudAnimate)
                }
            
            Image("cloud-right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(isMainViewBackground ? 1.3 : 1)
                .offset(.setOffset(fromX: 460,
                                   toX: 100, based:
                                    isRightCloudOnScreen))
                .offset(.setOffset(fromX: isMainViewBackground ? 130 : 95,
                                   toX: isMainViewBackground ? 145 : 110,
                                   fromY: isMainViewBackground ? 100 : 60,
                                   toY: isMainViewBackground ? 120 : 75,
                                   based: isRightCloudAnimate))
                .onAppear {
                    animationManager.set(animationType: .interpolatingSpring, 
                                         duration: 0.75,
                                         speed: 0.5,
                                         delay: 1,
                                         based: $isRightCloudOnScreen)
                    
                    animationManager.set(animationType: .linear,
                                         duration: 0.5,
                                         speed: 0.5,
                                         delay: 3,
                                         repeatForever: true,
                                         based: $isRightCloudAnimate)
                    
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .offset(y: -15)
    }
    
    
    @ViewBuilder func createWhiteSmokes() -> some View {
        HStack(alignment: .bottom) {
            Image("smoke-left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: isLeftSmokeAnimate ? 70 : 50, y: isLeftSmokeOnScreen ?  -20 : 150)
                .onAppear {
                    animationManager.set(animationType: .interpolatingSpring, 
                                         duration: 2,
                                         speed: 1,
                                         delay: 2,
                                         based: $isLeftSmokeOnScreen)
                    
                    animationManager.set(animationType: .linear,
                                         duration: 2,
                                         speed: 1, 
                                         delay: 2,
                                         repeatForever: true,
                                         based: $isLeftSmokeAnimate)
                }
            
            Spacer()
            
            Image("smoke-right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: isRightSmokeAnimate ? -70 : -50, y: isRightSmokeOnScreen ? -20 : 150)
                .onAppear {
                    animationManager.set(animationType: .interpolatingSpring,
                                         duration: 2,
                                         speed: 1, 
                                         delay: 2,
                                         based: $isRightSmokeOnScreen)
                    
                    animationManager.set(animationType: .linear,
                                         duration: 2,
                                         speed: 1,
                                         delay: 2,
                                         repeatForever: true,
                                         based: $isRightSmokeAnimate)
                }
        }
        .scaleEffect(1.7)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    BackgroundView(isRemoveFromScreen: .constant(false))
}
