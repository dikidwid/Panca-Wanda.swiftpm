//
//  GameViewModel.swift
//
//
//  Created by Diki Dwi Diro on 08/02/24.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    // MARK: - Move properties
    @Published var isTitleOnScreen: Bool = false
    @Published var isMasksOnScreen: Bool = false
    
    // MARK: - Tapped placeholder properties
    @Published var isLeftTopPlaceholderTapped: Bool = false
    @Published var isCenterTopPlaceholderTapped: Bool = false
    @Published var isRightTopPlaceholderTapped: Bool = false
    @Published var isLeftBottomPlaceholderTapped: Bool = false
    @Published var isRightBottomPlaceholderTapped: Bool = false
    
    
    // MARK: - Revealed mask properties
    @Published var isLeftTopPlaceholderRevealed: Bool = false
    @Published var isCenterTopPlaceholderRevealed: Bool = false
    @Published var isRightTopPlaceholderRevealed: Bool = false
    @Published var isLeftBottomPlaceholderRevealed: Bool = false
    @Published var isRightBottomPlaceholderRevealed: Bool = false
    
    
    // MARK: - Mask properties
    @Published var masks: [Mask] = Mask.allMasks
    @Published var randomMasks: [Mask] = Mask.allMasks.shuffled()
    @Published var containerMaskFrames: [CGRect] = [CGRect](repeating: CGRect(), count: Mask.allMasks.count)
    
    
    // MARK: - Other properties
    @Published var isShowCongratulationPopup: Bool = false
    @Published var isShowIncorrectPlacePopup: Bool = false
    @Published var isReturnedToMainView: Bool = false
    
    let animationManager: AnimationManager = AnimationManager()
    let audioPlayer: AudioPlayer = AudioPlayer() 
    
    var isAllRevealed: Bool {
        isLeftTopPlaceholderRevealed &&
        isCenterTopPlaceholderRevealed &&
        isRightTopPlaceholderRevealed &&
        isLeftBottomPlaceholderRevealed &&
        isRightBottomPlaceholderRevealed || masks.isEmpty
    }
    
    
    // MARK: - Drag mask functions
    func maskMoved(to location: CGPoint, mask: Mask) -> DragState {
        guard let index = containerMaskFrames.firstIndex(where: { $0.contains(location) }) else {
            return .unknown
        }
        
        let isPlaceholderRevealed = revealingFor(index)
        if isPlaceholderRevealed {
            return .unknown
        } else {
            return .good
        }
    }
    
    
    func maskDropped(to location: CGPoint, for movedMask: Mask) {
        guard let index = containerMaskFrames.firstIndex(where: { $0.contains(location) }) else {
            print("Not detected")
            return
        }
        
        if movedMask.id == randomMasks[index].id {
            print("Correct mask dropped at index \(index)")
            
            for (index, container) in randomMasks.enumerated() {
                if container.id == movedMask.id {
                    switch index {
                    case 0: isLeftTopPlaceholderRevealed = true
                    case 1: isCenterTopPlaceholderRevealed = true
                    case 2: isRightTopPlaceholderRevealed = true
                    case 3: isLeftBottomPlaceholderRevealed = true
                    case 4: isRightBottomPlaceholderRevealed = true
                    default: break
                    }
                }
            }
            withAnimation {
                if let draggableIndex = masks.firstIndex(where: { $0.id == movedMask.id }) {
                    masks.remove(at: draggableIndex)
                }
            }
        } else {
            withAnimation {
                isShowIncorrectPlacePopup = true
            }
        }
    }
    
    
    // MARK: - Placeholder functions
    func tappingFor(_ index: Int) -> Binding<Bool> {
        switch index {
        case 0: return Binding<Bool>(
            get: { self.isLeftTopPlaceholderTapped },
            set: { self.isLeftTopPlaceholderTapped = $0 }
        )
        case 1: return Binding<Bool>(
            get: { self.isCenterTopPlaceholderTapped },
            set: { self.isCenterTopPlaceholderTapped = $0 }
        )
        case 2: return Binding<Bool>(
            get: { self.isRightTopPlaceholderTapped },
            set: { self.isRightTopPlaceholderTapped = $0 }
        )
        case 3: return Binding<Bool>(
            get: { self.isLeftBottomPlaceholderTapped },
            set: { self.isLeftBottomPlaceholderTapped = $0 }
        )
        case 4: return Binding<Bool>(
            get: { self.isRightBottomPlaceholderTapped },
            set: { self.isRightBottomPlaceholderTapped = $0 }
        )
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func revealingFor(_ index: Int) -> Bool {
        switch index {
        case 0: return isLeftTopPlaceholderRevealed
        case 1: return isCenterTopPlaceholderRevealed
        case 2: return isRightTopPlaceholderRevealed
        case 3: return isLeftBottomPlaceholderRevealed
        case 4: return isRightBottomPlaceholderRevealed
        default: fatalError("Index out of bounds")
        }
    }
    
    
    func offsetForIndex(_ index: Int) -> CGSize {
        switch index {
        case 0: return CGSize(width: -250, height: -220)
        case 1: return CGSize(width: 0, height: -220)
        case 2: return CGSize(width: 250, height: -220)
        case 3: return CGSize(width: -250, height: 40)
        case 4: return CGSize(width: 250, height: 40)
        default: fatalError("Index out of bounds")
        }
    }
    
}
