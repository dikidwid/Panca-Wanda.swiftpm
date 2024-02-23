//
//  DraggableMask.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 07/02/24.
//

import SwiftUI

struct DraggableMask: View {
    @State private var dragAmount: CGSize = CGSize.zero
    @State private var dragState: DragState = .unknown
    
    let mask: Mask
    
    var onChanged: ((CGPoint, Mask) -> DragState)?
    var onEnded: ((CGPoint, Mask) -> Void)?
    
    var shadowColor: Color {
        switch dragState {
        case .unknown:
            return .clear
        case .good:
            return .yellow
        }
    }
    
    var body: some View {
        VStack {
            MaskImageView(mask: mask,
                          width: 150,
                          height: 250)
                .offset(dragAmount)
                .shadow(color: shadowColor, radius: 20)
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged { lastPosition in
                            withAnimation {
                                dragAmount = CGSize(width: lastPosition.translation.width,
                                                    height: lastPosition.translation.height)
                                dragState = onChanged?(lastPosition.location, mask) ?? .unknown
                            }
                        }
                        .onEnded { lastPosition in
                            if dragState == .good {
                                onEnded?(lastPosition.location, mask)
                            }
                            
                            dragAmount = CGSize.zero
                            dragState = .unknown
                        }
                )
            
        }
        
    }
}

#Preview {
    DraggableMask(mask: Mask.allMasks.first!)
}
