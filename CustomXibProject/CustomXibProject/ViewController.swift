//
//  ViewController.swift
//  CustomXibProject
//
//  Created by Amirthy Tejeshwar on 14/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var customUiView: CustomUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customUiView.label.text = "Hi Hello!"
        //customUiView.addSubview(customNib)
        
    }


}

