//
//  Concentration.swift
//  Concentration X
//
//  Created by Brandon Johns on 9/4/20.
//  Copyright © 2020 Brandon Johns. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
        
    {
        get
        {
            var foundIndex: Int?
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    // if we found our first card, remember it
                    if foundIndex == nil
                    {
                        foundIndex = index
                    } else
                    {
                        // If there are two, return nil.  There is no such thing
                        return nil
                    }
                }
            }
            //this will return the first faceup card or no faceup car (i.e. nil) - remember optionals get a free init to nil
            return foundIndex
        }
        set {
            for index in cards.indices
            {
                // the expression (index == newalue will be false unless they match
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    private var seenCard = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    
    func chooseCard(at index: Int)
    {
        assert(cards.indices.contains(index), "Concentration.chooseCardat: \(index)): chosen index not in the cards")
        if !cards[index].isMatched
        {
            flipCount += 1 
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            }
            else
            {
                //either no cards or 2 are face up
                indexOfOneAndOnlyFaceUpCard = index
                score -= 1
                
            }
               
        }
        
    }
    
    init(numberOfPairsOfCards: Int)
    {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        var lastCardIndex = cards.count - 1 ; 
        
        while lastCardIndex > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(lastCardIndex)))
            cards.swapAt(randomIndex, lastCardIndex)
            lastCardIndex -= 1
        }
    }
    
    func reset()
    {
        flipCount = 0
        score = 0
        for index in 0..<cards.count
        {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
   
}

