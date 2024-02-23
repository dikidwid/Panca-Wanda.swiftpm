//
//  SwiftUIView.swift
//  
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct MaskImageView: View {
    let mask: Mask
    let width: CGFloat?
    let height: CGFloat?
    var isUsedName: Bool?
    
    private var isShowName: Bool {
        return isUsedName ?? false
    }
    
    init(mask: Mask, width: CGFloat? = 250, height: CGFloat? = 250, isUsedName: Bool? = nil) {
        self.mask = mask
        self.width = width
        self.height = height
        self.isUsedName = isUsedName
    }
    
    var body: some View {
        Image(mask.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width ?? 250, height: height ?? 250)
            .shadow(color: .black, radius: 10)
            .background {
                Text(mask.name)
                    .font(.system(size: 27.5, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .offset(setOffset())
                    .opacity(isShowName ? 1 : 0)
            }
    }
    
    private func setOffset() -> CGSize {
        guard isShowName else { return CGSize.zero }
        
        if width! <= 200 && height! <= 200 {
            return CGSize(width: 0, height: 120)
        } else {
            return CGSize(width: 0, height: 150)
        }
    }
}

#Preview {
    MaskImageView(mask: Mask.allMasks.first!, isUsedName: true)
        .background {
            Color.gray
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}
