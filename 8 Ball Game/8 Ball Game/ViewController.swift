//
//  ViewController.swift
//  8 Ball Game
//
//  Created by Amirthy Tejeshwar on 09/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewAnswer: UIImageView!
    var imageArray  = [ "ball1" , "ball2" , "ball3" , "ball4" , "ball5" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeTheImage()
    }
    
    func changeTheImage(){
        imageViewAnswer.image = UIImage(named : imageArray[Int(arc4random_uniform(5))])
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeTheImage()
    }

    @IBAction func askButton(_ sender: Any) {
        changeTheImage()
    }
    
}

