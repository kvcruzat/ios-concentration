//
//  ViewController.swift
//  Concentration
//
//  Created by Khen Cruzat on 08/12/2017.
//  Copyright © 2017 Khen Cruzat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]! {
        didSet {
            loadEmoji()
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            if !game.cards[cardNumber].isFaceUp {
                game.chooseCard(at: cardNumber)
                updateViewFromModel()
            }
            
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    @IBAction func newGame(_ sender: UIButton) {
        emoji.removeAll()
        loadEmoji()
        Card.indentifierFactory = 0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                print("flip \(index)")
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.6910327673, green: 0.6910327673, blue: 0.6910327673, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flips) "
    }
    
    private var themes = [[String]]()
    private var emojiChoices = [String]()
    
    private var halloween = ["🦇", "🙀", "😱", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🤡"]
    private var christmas = ["🎄", "✨", "🎁", "⛄️", "❄️", "🎅🏻", "👼🏻"," 🦌", "🍪", "🧣"]
    private var animals = ["🐮", "🐔", "🐢", "🐷", "🦊", "🐼", "🐯", "🐰", "🐶", "🙊"]
    private var sports = ["🏀", "🏈", "⚾️", "⚽️", "🎱", "🥊", "🎾", "🏐", "🏓" ,"🎳"]
    private var faces = ["😀", "😍", "😘", "😂", "😎", "😜", "😭", "🙁", "🤮", "😡"]
    private var food = ["🍕", "🍖", "🍟", "🌮", "🌭", "🍗", "🍙", "🍔", "🍥", "🍣"]
    
    private func loadEmoji(){
        themes.removeAll()
        emojiChoices.removeAll()
        themes += [halloween, christmas, animals, sports, faces, food]
        
        let emojiTheme = themes.count.arc4random
        emojiChoices = themes[emojiTheme]
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

