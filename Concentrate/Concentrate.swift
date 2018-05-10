//
//  Concentrate.swift
//  Concentrate
//
//  Created by Ficus carica Linn on 17/03/2018.
//  Copyright © 2018 Ficus carica Linn. All rights reserved.
//

import Foundation
class Concentrate {
    var scores = 0, flipCounts = 0;
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isMatched == true {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex  
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        flipCounts += 1
        if !cards[index].isMatched { // this card not matched before being choosen
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { // the user didn't click the same card
                if cards[matchIndex].identifier == cards[index].identifier { // matched
                    cards[matchIndex].isMatched = true; cards[matchIndex].clickedTimes = 0
                    cards[index].isMatched = true; cards[index].clickedTimes = 0
                    scores += 2
                }
                cards[index].isFaceUp = true // whether matched or not, this card should be face up
                if  !cards[index].isMatched && cards[index].clickedTimes >= 1 && cards[matchIndex].clickedTimes >= 1 {
                    scores -= 1
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        cards[index].clickedTimes += 1
    }
    
    init(numberOfPairsOfCards: Int) { // amazing way of creating cards...
        for _ in 1...numberOfPairsOfCards { // do the following thing numberOfPairsOfCards times...
            let card = Card() // create a card
            cards += [card, card] // add two cards(with same information but they are different objects)
        }
        var shuffedCards = [Card]()
        for _ in 0..<(2*numberOfPairsOfCards) {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffedCards += [cards.remove(at: randomIndex)]
        }
        cards = shuffedCards
    }
}
