//
//  ViewController.swift
//  LifeCycle
//
//  Created by Gorantla Meghana on 19/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(" In 1st viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func button(_ sender: UIButton) {
        performSegue(withIdentifier: "segueIdentifier", sender: self)
    }
    
    @IBOutlet weak var editText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        print(" In 1st viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print(" In 1st viewWillLayoutSubViews")
    }
    
    override func viewDidLayoutSubviews() {
        print(" In 1st viewDidLayoutSubViews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(" In 1st viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(" In 1st viewWillDissappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(" In 1st viewDidDisappear")
    }
    
    deinit {
        print(" In 1st deinit")
    }
    
    override func didReceiveMemoryWarning() {
        print(" In 1st didReceiveMemoryWarning")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(" In 1st viewWillTransition")
    }
}

