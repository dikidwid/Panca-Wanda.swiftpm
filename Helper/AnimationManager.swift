//
//  AnimationManager.swift
//  
//
//  Created by Diki Dwi Diro on 11/02/24.
//

import SwiftUI

enum AnimationType {
    case linear
    case interpolatingSpring
}

struct AnimationManager {
    func set(animationType: AnimationType, duration: TimeInterval, speed: Double, delay: TimeInterval, repeatForever: Bool = false, based: Binding<Bool>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            var animation: Animation
            
            switch animationType {
            case .linear:
                animation = .linear(duration: duration).speed(speed)
            case .interpolatingSpring:
                animation = .interpolatingSpring(duration: duration).speed(speed)
            }
            
            if repeatForever {
                animation = animation.repeatForever(autoreverses: true)
            }
            
            withAnimation(animation) {
                based.wrappedValue.toggle()
            }
        }
    }
}
