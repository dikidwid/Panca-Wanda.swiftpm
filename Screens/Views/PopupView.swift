//
//  PopupView.swift
//  
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct PopupView: View {
    let title: String
    let description: String
    @Binding var isShowDismissButton: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            ZStack {
                createPopupBackground()
                
                VStack {
                    Text(title)
                        .font(.system(size: 40, weight: .semibold, design: .serif))
                        .foregroundStyle(.white)
                        .padding(.bottom, 20)
                    
                    
                    Text(description)
                        .font(.system(size: 25, weight: .regular, design: .serif))
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                }
                .shadow(color: .yellow, radius: 10)

                .padding(.horizontal, 50)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 45))
            .shadow(color: .black.opacity(0.5), radius: 10)
            .overlay {
                DismissButton(isShow: $isShowDismissButton)
                createClouds()
            }
            .frame(width: 500, height: 450)
        }
    }
    
    
    @ViewBuilder private func createPopupBackground() -> some View {
        Image("background-batik")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 500, height: 450)
            .clipped()
            .allowsHitTesting(false)
        
        LinearGradient(colors: [
            Color("customRedTop").opacity(0.95),
            Color("customRedTop").opacity(0.85),
            Color("customRedBottom").opacity(0.75)],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    
    
    @ViewBuilder private func createClouds() -> some View {
        Image("cloud-left")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 230, height: 230)
            .offset(x: -220, y: -200)
        
        Image("cloud-right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350, height: 350)
            .offset(x: 170, y: 240)
    }
}

#Preview {
    PopupView(title: "Test",
              description: "test", 
              isShowDismissButton: .constant(false))
}
