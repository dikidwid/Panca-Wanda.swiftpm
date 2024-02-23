//
//  DismissButton.swift
//
//
//  Created by Diki Dwi Diro on 09/02/24.
//

import SwiftUI

struct DismissButton: View {
    @Binding var isShow: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isShow = false
            }
        } label: {
            Image(systemName: "xmark.app")
                .imageScale(.large)
                .scaleEffect(2)
                .foregroundStyle(.yellow)
                
                .shadow(color: .yellow, radius: 5)
                .padding([.top, .trailing], 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

#Preview {
    DismissButton(isShow: .constant(true))
}
