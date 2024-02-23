//
//  Mask.swift
//  WWDC24 Panca Wanda
//
//  Created by Diki Dwi Diro on 07/02/24.
//

import Foundation

struct Mask: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let color: String
    let symbols: [String]
    let description: String
}

enum DragState {
    case unknown
    case good
}

extension Mask {
    static let allMasks: [Mask] = [
        
        Mask(name: "Panji",
             image: "panji-mask",
             color: "Pure White",
             symbols: ["Newborn phase",
                       "White soul and clean",
                       "Pure and pious"],
             description: "Panji mask depicts someone who is pure and has just been born into the world. The white color that dominates this mask is a depiction of a baby who is still clean. He only moves in one place without moving, which shows the meaning of the essence of silence and the essence of motion."),
        
        Mask(name: "Samba",
             image: "samba-mask",
             color: "White",
             symbols: ["Children phase",
                       "Cheerful and funny",
                       "Cute and innocent"],
             description: "Samba mask depicts someone who is entering the childhood phase. It also depiction of a child who has just learned to walk. Because the role is to represent children, So the movements made by this mask are so agile and also funny. Similar to the behavior of children."),
        
        Mask(name: "Rumyang",
             image: "rumyang-mask",
             color: "Pink",
             symbols: ["Teenage phase",
                       "Step on age of puberty",
                       "Flirty and agile"],
             description: "Rumyang mask is a depiction of a human being who has entered the teenage phase. It has agile movement that symbolizes a teenager who starts to be curious about many things. Dancers who use this mask will perform a movement that contains a message that all humans should do good."),
        
        Mask(name: "Tumenggung",
             image: "tumenggung-mask",
             color: "Brown",
             symbols: ["Adult phase",
                       "Established and steady",
                       "Authoritative and calm"],
             description: "Tumenggung mask is a depiction of a human who has found their identity and calm.  This Mask are the impression of personality and a loyal attitude. The character presented by this mask gives a message about the characteristics and personality with high loyalty."),
        
        Mask(name: "Kelana",
             image: "kelana-mask",
             color: "Red",
             symbols: ["Maturity and lust",
                       "Anger and human greed",
                       "Arrogant and cruel",],
             description: "Kelana is a symbol of the highest level of life because it is included in the category of people who are perfect with the maturity of the mind. Even though it shows an evil role, this mask teaches an important lesson. That humans must try to get life and happiness in a good way.")
    ]
}

