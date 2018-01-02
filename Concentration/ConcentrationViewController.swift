//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Khen Cruzat on 08/12/2017.
//  Copyright © 2017 Khen Cruzat. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (visibleCardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]! {
        didSet {
//            loadEmoji()
        }
    }
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = visibleCardButtons.index(of: sender){
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
//        loadEmoji()
        Card.indentifierFactory = 0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
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
            let scoreText = traitCollection.verticalSizeClass == .compact ? "Score\n\(game.score)" : "Score: \(game.score)"
            scoreLabel.text = scoreText
            flipCountLabel.text = "Flips: \(game.flips) "
        }
        
    }
    
    private let themes: [String:[String]] = [
        "halloween" : ["🦇", "🙀", "😱", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🤡"] ,
        "christmas" : ["🎄", "✨", "🎁", "⛄️", "❄️", "🎅🏻", "👼🏻"," 🦌", "🍪", "🧣"],
        "animals" : ["🐮", "🐔", "🐢", "🐷", "🦊", "🐼", "🐯", "🐰", "🐶", "🙊"],
        "sports" : ["🏀", "🏈", "⚾️", "⚽️", "🎱", "🥊", "🎾", "🏐", "🏓" ,"🎳"],
        "faces" : ["😀", "😍", "😘", "😂", "😎", "😜", "😭", "🙁", "🤮", "😡"],
        "food" : ["🍕", "🍖", "🍟", "🌮", "🌭", "🍗", "🍙", "🍔", "🍥", "🍣"]
        ]
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme ?? [""]
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    var emojiChoices: [String]?
    
    private func loadEmoji(){
        if emojiChoices != nil {
            emojiChoices?.removeAll()
        }
        
        let randomIndex = themes.count.arc4random
        let key = Array(themes.keys)[randomIndex]
        emojiChoices = themes[key]!
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices != nil, emojiChoices!.count > 0 {
            emoji[card] = emojiChoices!.remove(at: emojiChoices!.count.arc4random)
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

