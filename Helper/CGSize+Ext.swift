//
//  File.swift
//  
//
//  Created by Diki Dwi Diro on 11/02/24.
//

import Foundation

extension CGSize {
    static func setOffset(fromX : CGFloat = 0,
                           toX: CGFloat = 0,
                           fromY: CGFloat = 0,
                           toY: CGFloat = 0,
                           based isOnScreen : Bool = false) -> CGSize {
        guard isOnScreen else {
            return CGSize(width: fromX, height: fromY)
        }
        
        let moveOffsetHorizontally = CGSize(width: toX, height: toY)
        return moveOffsetHorizontally
    }
}
