//
//  Concentration.swift
//  
//
//  Created by Khen Cruzat on 08/12/2017.
//

import Foundation

struct Concentration{
    
    private(set) var cards = [Card]()
    
    var score = 0
    var flips = 0
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        flips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].beenSeen {
                        score -= 1
                    }
                    if cards[matchIndex].beenSeen {
                        score -= 1
                    }
                }
                cards[index].beenSeen = true
                cards[matchIndex].beenSeen = true
                cards[index].isFaceUp = true
            } else {
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least 1 pair of cards")
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        var last = cards.count - 1
        
        while last > 0 {
            let rand = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, rand)
            last -= 1
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
