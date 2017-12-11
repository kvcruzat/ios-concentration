//
//  Card.swift
//  
//
//  Created by Khen Cruzat on 08/12/2017.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var beenSeen = false
    private var identifier: Int
    
    static var indentifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
