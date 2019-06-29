//
//  CustomViewController.swift
//  SampleTestCustomMain
//
//  Created by Amirthy Tejeshwar on 21/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var welcomLabel: UILabel!
    
    
    @IBAction func goToNextButton(_ sender: Any) {
       
        let secondViewController = SecondViewController(nibName: "SecondViewController", bundle: nil)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
