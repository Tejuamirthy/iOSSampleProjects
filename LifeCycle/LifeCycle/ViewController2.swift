//
//  ViewController2.swift
//  LifeCycle
//
//  Created by Gorantla Meghana on 19/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" In 2st viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(" In 2st viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print(" In 2st viewWillLayoutSubViews")
    }
    
    override func viewDidLayoutSubviews() {
        print(" In 2st viewDidLayoutSubViews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(" In 2st viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(" In 2st viewWillDissappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(" In 2st viewDidDisappear")
    }
    
    deinit {
        print(" In 2st deinit")
    }
    
    override func didReceiveMemoryWarning() {
        print(" In 2st didReceiveMemoryWarning")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(" In 2st viewWillTransition")
    }
    
}
