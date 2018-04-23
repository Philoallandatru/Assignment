//
//  ViewController.swift
//  Concentrate
//
//  Created by Ficus carica Linn on 17/03/2018.
//  Copyright © 2018 Ficus carica Linn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentrate(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(game.flipCounts)"
        }
    }
    
    var vscores = 0 {
        didSet {
            scores.text = "Scores: \(vscores)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]! // card buttom are all in the array here.
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) { // get the index of the card that you click
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not included")
        }
        vscores = game.scores;
    }
    
    /* check state of every card in the cards array, update view according its state */
    func updateViewFromModel() {
        for index in cardButtons.indices { // go throught all the cards
            let button = cardButtons[index] // every card buttom
            let card = game.cards[index] // the same index as the cardButtoms
            if card.isFaceUp {  // set the title of the card randomly from emoji choices
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal) // no title, no emoji display in that card
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // cards which are faced down and matched should disappear
            }
        }
    }
    
    // themes
    var emojiThemese:[Array<String>] = [["⛷", "🏂", "🏋️‍♀️", "🤸‍♂️", "🤼‍♀️", "⛹️‍♀️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏌️‍♂️", "🏇", "🧘‍♂️", "🏄‍♀️", "🏄‍♂️", "🧗‍♂️", "🚵‍♀️", "🚴‍♀️"], ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "🏑", "🏏", "🏹", "🎣", "🥊", "🥋", "⛸", "🥌", "🛷", "🎿"], ["🍏", "🍎", "🍊", "🍋", "🍌", "🍉", "🍒", "🍑", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥒", "🌽", "🥐", "🥞", "🍔", "🍟"], ["🌞", "🌝", "🌛", "🌜", "🌚", "🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔", "🌙", "💫", "⭐️", "🌟", "✨", "☄️", "💥"], ["🦊", "🐯", "🐷", "🐣", "🐧", "🐼", "🐹", "🐶", "🐰", "🦁", "🐻", "🐸", "🐬"], ["😀", "😂", "🤣", "😇", "😍", "😜", "😎", "🤪", "🤩", "😡", "🤬"]]
    
    var emoji = [Int: String]() // identifier : emoji string pair
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    /*
     input: card object
     output: an emoji randomly chosen from an emoji array
     effect: this relationship is also stored in an identifier : string dictionary
     called when: you click a card, and need update the view, you choose an emoji the card faced up
     */
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 { // if the relationship hasn't been created
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count))) // no auto-conversion in Swift
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // use one emoji just once
        }
        return emoji[card.identifier] ?? "?"
    }

    @IBAction func startANewGame(_ sender: UIButton) {
        game = Concentrate(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemese.count)))
        emojiChoices = emojiThemese[randomIndex]
        updateViewFromModel()
    }
}

