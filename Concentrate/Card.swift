//
//  Card.swift
//  Concentrate
//
//  Created by Ficus carica Linn on 17/03/2018.
//  Copyright © 2018 Ficus carica Linn. All rights reserved.
//

import Foundation

struct Card {
    // status of a card
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var clicked = false
    
    // MARK: I love you
    // give each card an unique identifier when it is created
    static var identifierFactory = 0
    
    // each time you call this fnction rhe indentifier increases by 1
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
