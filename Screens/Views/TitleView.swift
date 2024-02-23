//
//  SwiftUIView.swift
//  
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct TitleView: View {
    let text: String
    let isMainView: Bool
    
    let animationManager: AnimationManager = AnimationManager()

    @State private var isAnimate = true
    
    init(text: String, isMainView: Bool = false) {
        self.text = text
        self.isMainView = isMainView
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: isMainView ? 75 : 40, weight: .heavy, design: .serif))
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .tracking(isMainView ? 5 : 0)
            .scaleEffect(isAnimate ? 1.05 : 1, anchor: .center)
            .shadow(color: .black.opacity(0.50), radius: 8, x: 0, y: 17)
        
            .padding(.top, 80)
            .onAppear {
                animationManager.set(animationType: .linear,
                                     duration: 1,
                                     speed: 0.5,
                                     delay: 1,
                                     repeatForever: true,
                                     based: $isAnimate)
            }
    }
}

#Preview {
    TitleView(text: "Try to explore")
}
