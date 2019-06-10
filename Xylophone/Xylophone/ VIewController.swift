//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate{
    
    var audioPlayer :AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
        let url = Bundle.main.url(forResource: "note"+String(sender.tag), withExtension: "wav")
        
        do{
            audioPlayer  = try AVAudioPlayer(contentsOf: url!)
            
        }
        catch{
            print(error)
        }
        audioPlayer.play()
        
    }
    
  

}

