//
//  ViewController.swift
//  Concentration
//
//  Created by Egor Rybin on 04.07.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = ConcentrationGame(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributedString
    }
    
    private(set) var touches = 0 {
        didSet{
            updateTouches()
        }
    }
    
    
    //private var emojiCollection = ["🐼","🦁","🐯","🐱","🐮","🐷","🐤","🐸","🐶"]
    private var emojiCollection = "🐼🦁🐯🐱🐮🐷🐤🐸🐶"
    
    private var emojiDictionary = [Card:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        //if emojiDictionary[card.identifier] != nil {
        //    return emojiDictionary[card.identifier]!
        //} else {
        //    return "?"
        //}
        if emojiDictionary[card] == nil {
            //let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
            
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.white : UIColor(red: 67/255, green: 134/255, blue: 219/255, alpha: 1.0)
                
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet{
            updateTouches()
        }
    }
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            
        }
    }
    
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
