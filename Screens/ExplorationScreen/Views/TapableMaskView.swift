//
//  MaskView.swift
//
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct TapableMaskView: View {
    let mask: Mask
    let animationManager: AnimationManager = AnimationManager()
    @Binding var isTapped: Bool
    @Binding var isShowDetailmask: Bool
    @Binding var isShowMasksName: Bool
    
    var isMaskTapped: ((Mask) -> Void)?
    
    var body: some View {
       MaskImageView(mask: mask,
                     isUsedName: isShowMasksName)
            .overlay {
                if isTapped {
                    addCheckmark()
                }
            }
            .onTapGesture {
                isTapped = true
                withAnimation {
                    isShowDetailmask = true
                    isMaskTapped?(mask)
                }
            }
    }
    
    
    @ViewBuilder private func addCheckmark() -> some View {
        ZStack {
            Image(mask.image)
            .resizable()
            .renderingMode(.template).opacity(0.9)
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .scaleEffect(2)
                .imageScale(.large)
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    TapableMaskView(mask: Mask.allMasks.first!, isTapped: .constant(false), isShowDetailmask: .constant(false), isShowMasksName: .constant(true))
}
