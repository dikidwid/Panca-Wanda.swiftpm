//
//  File.swift
//  
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    // MARK: - Move properties
    
    @Published var isTitleOnScreen: Bool = false
    @Published var isMasksOnScreen: Bool = false
    
    
    // MARK: - Animate properties
    
    @Published var isPanjiMaskAnimate: Bool = false
    @Published var isSambaMaskAnimate: Bool = false
    @Published var isRumyangMaskAnimate: Bool = false
    @Published var isTumenggungMaskAnimate: Bool = false
    @Published var isKelanaMaskAnimate: Bool = false
    
    @Published var isTapAnywhereAnimate: Bool = false
    

    // MARK: - Other Properties
    
    @Published var isRemoveBackground: Bool = false
    @Published var showIntroductionScreen: Bool = false
    
    let masks: [Mask] = Mask.allMasks
    
    let animationManager: AnimationManager = AnimationManager()
    let audioPlayer: AudioPlayer = AudioPlayer()
    
    
    // MARK: - Create the mask functions
    
    func inTransitionFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return .setOffset(fromX: 600, fromY: 500, based: isMasksOnScreen)
            
        case 1: return .setOffset(fromX: -600, fromY: 500, based: isMasksOnScreen)
            
        case 2: return .setOffset(fromX: -500, fromY: -500, based: isMasksOnScreen)
            
        case 3: return .setOffset(fromX: 500, fromY: -500, based: isMasksOnScreen)
            
        case 4: return .setOffset(fromY: -750, based: isMasksOnScreen)
            
        default: fatalError("Index out of bounds")
        }
    }
        
    
    func setMaskOffsetFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return  .setOffset(fromX: 80, toX: 85, fromY: 135, toY: 135, based: isPanjiMaskAnimate)
            
        case 1: return .setOffset(fromX: -80, toX: -85, fromY: 135, toY: 135, based: isSambaMaskAnimate)
            
        case 2: return .setOffset(fromX: -140, toX: -150, fromY: -20, toY: -30, based: isRumyangMaskAnimate)
            
        case 3: return .setOffset(fromX: 140, toX: 150, fromY: -20, toY: -30, based: isTumenggungMaskAnimate)
            
        case 4: return .setOffset(fromY: -95, toY: -110, based: isKelanaMaskAnimate)
            
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func rotationEffectFor(_ index: Int) -> Angle {
        switch index {
        case 0: return Angle(degrees: isPanjiMaskAnimate ? -2 : 2)
        case 1: return Angle(degrees: isSambaMaskAnimate ? 2 : -2)
        case 2: return Angle(degrees: isRumyangMaskAnimate ? 0 : 0)
        case 3: return Angle(degrees: isTumenggungMaskAnimate ? 0 : 0)
        case 4: return Angle(degrees: isKelanaMaskAnimate ? 0 : 0 )
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func setMaskAnimationFor(_ index: Int) -> Animation {
        switch index {
        case 0:
            let animation = Animation
                .linear(duration: 0.5)
                .speed(0.5)
                .repeatForever(autoreverses: true)
            return animation
        case 1:
            let animation = Animation
                .linear(duration: 0.5)
                .speed(0.5)
                .repeatForever(autoreverses: true)
            return animation
        case 2:
            let animation = Animation
                .linear(duration: 0.5)
                .speed(0.5)
                .repeatForever(autoreverses: true)
            return animation
        case 3:
            let animation = Animation
                .linear(duration: 0.5)
                .speed(0.5)
                .repeatForever(autoreverses: true)
            return animation
        case 4:
            let animation = Animation
                .linear(duration: 0.5)
                .speed(0.5)
                .repeatForever(autoreverses: true)
            return animation
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func setAnimationValueFor(_ index: Int) -> Binding<Bool> {
        switch index {
        case 0: return Binding<Bool>(
            get: { self.isPanjiMaskAnimate },
            set: { self.isPanjiMaskAnimate = $0 }
        )
        case 1: return Binding<Bool>(
            get: { self.isSambaMaskAnimate },
            set: { self.isSambaMaskAnimate = $0 }
        )
        case 2: return Binding<Bool>(
            get: { self.isRumyangMaskAnimate },
            set: { self.isRumyangMaskAnimate = $0 }
        )
        case 3: return Binding<Bool>(
            get: { self.isTumenggungMaskAnimate },
            set: { self.isTumenggungMaskAnimate = $0 }
        )
        case 4: return Binding<Bool>(
            get: { self.isKelanaMaskAnimate },
            set: { self.isKelanaMaskAnimate = $0 }
        )
        default: fatalError("Index out of bounds")
        }
    }
}
