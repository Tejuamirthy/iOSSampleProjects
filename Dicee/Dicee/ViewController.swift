//
//  ViewController.swift
//  Dicee
//
//  Created by Amirthy Tejeshwar on 09/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomDiceIndexOne : Int = 0
    var randomDiceIndexTwo : Int = 0
    
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    
    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImage()
    }

    @IBAction func rollButton(_ sender: Any) {
        updateDiceImage()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImage()
    }
    
    func updateDiceImage(){
        randomDiceIndexOne = Int(arc4random_uniform(6))
        randomDiceIndexTwo = Int(arc4random_uniform(6))
        
        print("\(randomDiceIndexOne)"+"  "+"\(randomDiceIndexTwo)")
        
        diceImageViewOne.image = UIImage(named: diceArray[randomDiceIndexOne])
        diceImageViewTwo.image = UIImage(named: diceArray[randomDiceIndexTwo])
    }
    
}

