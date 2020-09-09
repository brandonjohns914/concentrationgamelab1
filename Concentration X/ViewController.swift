//
//  ViewController.swift
//  Concentration X
//
//  Created by Brandon Johns on 8/31/20.
//  Copyright © 2020 Brandon Johns. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int
    {
        return (cardButtons.count+1) / 2
    }
    
    
    
    @IBAction func newGame(_ sender: UIButton)
    {
            emoji.removeAll()
            game.reset()
            updateViewFromModel()
            emoji = [Int:String]()
            RandomSelection()
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBAction func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.firstIndex(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else
        {
            print ("Chosen card not in CardButton")
        }
        
    }
    private func updateViewFromModel()
    {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0) : #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
            }
        }
    }
    
    private var emoji = [Int :String]()
   
    
    private let themes = [
         ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🐧","🐴","🐺","🦉","🦄","🦅","🐙","🦞","🐳","🦛"]
        ,["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥬","🥒","🌶","🌽","🥕","🧄"]
        ,["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛","🚜","🏍","🛺","🚔","🚍","🚘","🛵","🛺","✈️","🛩","🚆","🛥","🚁","🚂"]
        ,["🇩🇪","🇬🇷","🇵🇷","🇯🇵","🇱🇷","🇳🇿","🇳🇴","🇬🇧","🇺🇸","🇻🇳","🏳️","🏴","🏴‍☠‍","🏁","🏳️‍🌈","🇨🇦","🇨🇮","🇭🇷","🇫🇮","🇫🇷","🇲🇺","🇲🇰","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🏴󠁧󠁢󠁳󠁣󠁴󠁿","🇻🇮","🏴󠁧󠁢󠁷󠁬󠁳󠁿"]
        ,["😬","😂","😀","🤔","🧐","🙃","😌","🤨","😳","😀","🤣","😅","🤪","🤭","🙄","🥴","😇","🤩","😎","😕","🥺","🤯","😣","😤","😠","😱"]
         ]
    
    private var emojiChoices: [String] = []
    
    private func RandomSelection()
    {
        return emojiChoices = themes[themes.count.arc4random]
    }
    
    private func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0
            {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }

        return emoji[card.identifier] ?? "?"
    }
    
    
}

extension Int
{
    var arc4random: Int
    {
        if self > 0
        {
            return Int(arc4random_uniform(UInt32(self)))
            
        }
        else if self < 0
        {
            return -Int(arc4random_uniform(UInt32(abs(self))))
            
        }
        else
        {return 0
            
        }
        
    }
    
}
 





