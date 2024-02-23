//
//  IntroductionViewModel.swift
//
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

final class IntroductionViewModel: ObservableObject {
    
    // MARK: - Move properties
    
    @Published var isTitleOnScreen: Bool = false
    @Published var isMasksOnScreen: Bool = false
    @Published var isDescriptionOnScreen: Bool = false
    
    @Published var isMasksOutScreen: Bool = false
    @Published var isShowMasksName: Bool = false
    
    // MARK: - Animate properties
    
    @Published var isPanjiMaskAnimate: Bool = false
    @Published var isSambaMaskAnimate: Bool = false
    @Published var isRumyangMaskAnimate: Bool = false
    @Published var isTumenggungMaskAnimate: Bool = false
    @Published var isKelanaMaskAnimate: Bool = false
    
    @Published var isTapToContinueAnimate: Bool = false
    
    @Published var isRemoveBackground: Bool = false
    

    // MARK: - Other Properties
    
    @Published var showExplorationView: Bool = false
    @Published var tapCount: Int = 0
    @Published var descriptionTextType: Description = .first
    
    let masks: [Mask] = Mask.allMasks
    
    let animationManager: AnimationManager = AnimationManager()
    
    enum Description {
        case first
        case second
        case third
        
        var text: String {
            switch self {
            case .first:
                " is a mask used in a traditional dance called Tari Topeng where its originally from Cirebon, West Java, Indonesia.\n\nJust like its name, the dancer in this art always wears a mask when performing the dance. There are five types of masks in this art, each with its own name and philosophical meaning."
                
            case .second:
                " is a combination of two words, namely \"Panca\" means Five and \"Wanda\" means Form. So, Panca Wanda is five forms.\n\nIt depicts the character of human life, which starts from the birth of a human until old age. Despite the scary appearance of the mask, these mask has meaning and moral message."
            case .third:
                " mask has five shapes and types, namely Panji, Samba, Rumyang, Tumenggung, and Kelana. All types of masks will be worn during Cirebon mask dance performances as one of the complementary accessories and each mask represents five different roles."
            }
        }
    }
    
    
    // MARK: - Create the mask functions
    
    func inTransitionFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return .setOffset(fromX: 600, fromY: 500, based: isMasksOnScreen)
            
        case 1: return .setOffset(fromX: -600, fromY: 500, based: isMasksOnScreen)
            
        case 2: return .setOffset(fromX: -500, fromY: -500, based: isMasksOnScreen)
            
        case 3: return .setOffset(fromX: 500, fromY: -500, based: isMasksOnScreen)
            
        case 4: return .setOffset(fromY: -650, based: isMasksOnScreen)
            
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
    
    func setMaskNameOffsetFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return .setOffset(toX: 70, toY: 135, based: isShowMasksName)
            
        case 1: return .setOffset(toX: -70, toY: 135, based: isShowMasksName)
            
        case 2: return .setOffset(toX: -130, toY: 0, based: isShowMasksName)
            
        case 3: return .setOffset(toX: 130, toY: 0, based: isShowMasksName)
            
        case 4: return .setOffset(toX: 0, toY: -30, based: isShowMasksName)
            
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func rotationEffectFor(_ index: Int) -> Angle {
        switch index {
        case 0: return Angle(degrees: isPanjiMaskAnimate && !isShowMasksName ? -2 : 2)
        case 1: return Angle(degrees: isSambaMaskAnimate && !isShowMasksName ? 2 : -2)
        case 2: return Angle(degrees: isRumyangMaskAnimate ? 0 : 0)
        case 3: return Angle(degrees: isTumenggungMaskAnimate ? 0 : 0)
        case 4: return Angle(degrees: isKelanaMaskAnimate ? 0 : 0 )
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func maskAnimationFor(_ index: Int) -> Animation {
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
    
    
    func animationValueFor(_ index: Int) -> Binding<Bool> {
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
