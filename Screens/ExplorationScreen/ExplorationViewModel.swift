//
//  ExplorationViewModel.swift
//
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

final class ExplorationViewModel: ObservableObject {

    // MARK: - Move properties
    @Published var isTitleOnScreen: Bool = false
    @Published var isInstructionsOnScreen: Bool = false
    @Published var isShowMasksName: Bool = false
    @Published var isMasksOnScreen: Bool = false
    
    
    // MARK: - Animate properties
    
    @Published var isPanjiMaskAnimate: Bool = false
    @Published var isSambaMaskAnimate: Bool = false
    @Published var isRumyangMaskAnimate: Bool = false
    @Published var isTumenggungMaskAnimate: Bool = false
    @Published var isKelanaMaskAnimate: Bool = false
    
    // MARK: - Tap mask properties
    
    @Published var isPanjiMaskTapped: Bool = false
    @Published var isSambaMaskTapped: Bool = false
    @Published var isRumyangMaskTapped: Bool = false
    @Published var isTumenggungMaskTapped: Bool = false
    @Published var isKelanaMaskTapped: Bool = false
    
    // MARK: - Other properties
    
    @Published var isShowPopup: Bool = false
    @Published var isShowDetailMask: Bool = false
    @Published var showGameView: Bool = false
    
    @Published var tappedMask: Mask = Mask.allMasks[0]
    
    let masks = Mask.allMasks
    
    let animationManager: AnimationManager = AnimationManager()
    
    var isAllMaskTapped: Bool {
            isPanjiMaskTapped &&
            isSambaMaskTapped &&
            isRumyangMaskTapped &&
            isTumenggungMaskTapped &&
            isKelanaMaskTapped
    }
    
    // MARK: - Tapping mask functions
    
    func tappingFor(_ index: Int) -> Binding<Bool> {
        switch index {
        case 0: return Binding<Bool>(
            get: { self.isPanjiMaskTapped },
            set: { self.isPanjiMaskTapped = $0 }
        )
        case 1: return Binding<Bool>(
            get: { self.isSambaMaskTapped },
            set: { self.isSambaMaskTapped = $0 }
        )
        case 2: return Binding<Bool>(
            get: { self.isRumyangMaskTapped },
            set: { self.isRumyangMaskTapped = $0 }
        )
        case 3: return Binding<Bool>(
            get: { self.isTumenggungMaskTapped },
            set: { self.isTumenggungMaskTapped = $0 }
        )
        case 4: return Binding<Bool>(
            get: { self.isKelanaMaskTapped },
            set: { self.isKelanaMaskTapped = $0 }
        )
        default: fatalError("Index out of bounds")
        }
    }
    
    // MARK: - Create mask functions
    
    func inTransitionOffsetFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return  .setOffset(fromX: 75, fromY: 110)
        case 1: return .setOffset(fromX: -75, fromY: 110)
        case 2: return .setOffset(fromX: -130, fromY: -30)
        case 3: return .setOffset(fromX: 130, fromY: -30)
        case 4: return .setOffset(fromY: -110)
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func setMaskOffsetFor(_ index: Int) -> CGSize {
        switch index {
        case 0: return .setOffset(toX: 70, toY: 180, based: isShowMasksName)
        case 1: return .setOffset(toX: -70,toY: 180, based: isShowMasksName)
        case 2: return .setOffset(toX: -150, toY: -20, based: isShowMasksName)
        case 3: return .setOffset(toX: 150, toY: -20, based: isShowMasksName)
        case 4: return .setOffset(toY: -140, based: isShowMasksName)
        default: fatalError("Index out of bounds")
        }
    }
}
