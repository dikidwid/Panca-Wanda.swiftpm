//
//  DetailMaskView.swift
//
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct DetailMaskView: View {
    let mask: Mask
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            ZStack {
                createPopupBackground()
                
                VStack {
                    createImageMask()
                    
                    Spacer().frame(height: 100)
                    
                    createTextForFaceColor()
                    
                    createTextForSymbols()
                    
                    createTextForDescription()
                    
                    Spacer().frame(height: 80)
                }
                .shadow(color: .yellow, radius: 10)
                .padding(.horizontal, 50)
            }
            .clipShape(RoundedRectangle(cornerRadius: 45))
            .shadow(color: .black.opacity(0.5), radius: 10)
            .overlay {
                DismissButton(isShow: $isShow)
                createClouds()
            }
            .frame(width: 600, height: 952)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    
    @ViewBuilder private func createPopupBackground() -> some View {
        LinearGradient(colors: [
            Color("customRedTop").opacity(0.95),
            Color("customRedTop").opacity(0.85),
            Color("customRedTop").opacity(0.75)],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .background {
            Image("background-batik")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    
    @ViewBuilder private func createImageMask() -> some View {
        ZStack {
            ZStack {
                Image("background-batik")
                    .resizable()
                    .mask(alignment: .center) {
                        ZStack {
                            Capsule()
                                .trim(from: 0, to: 0.5)
                                .rotation(Angle(degrees: 180))
                            
                            Rectangle()
                                .frame(width: 200, height: 100)
                                .offset(y: 50)
                        }
                    }
                    .opacity(0.25)
                
                Capsule()
                    .trim(from: 0, to: 0.5)
                    .rotation(Angle(degrees: 180))
                    .stroke(style: StrokeStyle(lineWidth: 2.5))
                
                Rectangle()
                    .trim(from: 0.335, to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 2.5))
                    .frame(width: 200, height: 100)
                    .offset(y: 50)
            }
            .foregroundStyle(.white)
            .frame(width: 200, height: 250)
            
            MaskImageView(mask: mask, isUsedName: true)
                .offset(y: 30)
            
        }
        .padding(.top, 40)
        .padding(.bottom, 50)
    }
    
    
    @ViewBuilder private func createTextForFaceColor() -> some View {
        HStack(alignment: .top) {
            Text("Face Color:")
                .font(.system(size: 25, weight: .semibold, design: .serif))
                .foregroundStyle(.white)
                .padding(.trailing)
            
            Text(mask.color)
                .font(.system(size: 25, weight: .regular, design: .serif))
                .foregroundStyle(.white.opacity(0.75))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
    
    
    @ViewBuilder private func createTextForSymbols() -> some View {
        HStack(alignment: .top) {
            Text("Symbols:")
                .font(.system(size: 25, weight: .semibold, design: .serif))
                .foregroundStyle(.white)
                .padding(.trailing, 45)
            
            VStack(alignment: .leading){
                ForEach(mask.symbols, id: \.self) { symbol in
                    Text("- \(symbol)")
                        .font(.system(size: 25, weight: .regular, design: .serif))
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
    
    
    @ViewBuilder private func createTextForDescription() -> some View {
        VStack(alignment: .leading) {
            Text("Description:")
                .font(.system(size: 25, weight: .semibold, design: .serif))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 5)
            
            Text(mask.description)
                .font(.system(size: 25, weight: .regular, design: .serif))
                .foregroundStyle(.white.opacity(0.75))
                .multilineTextAlignment(.leading)
        }
    }
    
    
    @ViewBuilder private func createClouds() -> some View {
        Image("cloud-left")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
            .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment: .topLeading)
            .offset(x:  -80, y: -75)
        
        Image("cloud-right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350, height: 350)
            .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment: .bottomTrailing)
            .offset(x: 80, y: 190)
    }
}

#Preview {
    DetailMaskView(mask: Mask.allMasks[0], isShow: .constant(true))
}
