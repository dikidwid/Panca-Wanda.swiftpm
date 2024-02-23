//
//  ContainerMaskView.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 08/02/24.
//

import SwiftUI

struct PlaceholderView: View {
    let mask: Mask
    let isRevealed: Bool
    @Binding var isTapped: Bool
    
    var clue: String {
        mask.symbols.randomElement()!
    }
        
    var body: some View {
        if isRevealed {
            createRevealedMask()
        } else {
            VStack {
               createPlaceholderMask()
            }
            .onTapGesture {
                showMaskClueInTwoSeconds()
            }
            .disabled(isTapped)
        }
    }
    
    
    private func showMaskClueInTwoSeconds() {
        withAnimation {
            isTapped = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)  {
                withAnimation {
                    isTapped = false
                }
            }
        }
    }
    
    
    @ViewBuilder private func createRevealedMask() -> some View {
        MaskImageView(mask: mask,
                      width: 200,
                      height: 200,
                      isUsedName: true)
    }
    
    
    @ViewBuilder private func createPlaceholderMask() -> some View {
        Image("placeholder-mask")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 175)
            .overlay {
                ZStack {
                    Text("Tap to\nget clues")
                        .font(.system(size: 22.5, weight: .semibold, design: .serif))
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .offset(y: -7.5)
                    
                    Image("clue")
                        .resizable()
                        .frame(width: 175)
                        .overlay (alignment: .center){
                            Text(clue)
                                .font(.system(size: 18, weight: .regular, design: .serif))
                                .multilineTextAlignment(.center)
                                .frame(width: 120, height: 80, alignment: .top)
                        }
                        .offset(x: 80, y: -70)
                        .opacity(isTapped ? 1 : 0)
                }
            }
        
        Text("???")
            .font(.system(size: 27.5, weight: .semibold, design: .serif))
            .foregroundStyle(.white)
    }
}

#Preview {
    PlaceholderView(mask: Mask.allMasks.first!,
                      isRevealed: false,
                      isTapped: .constant(true))
}
