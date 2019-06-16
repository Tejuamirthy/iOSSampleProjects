//
//  CustomUIView.swift
//  CustomXibProject
//
//  Created by Amirthy Tejeshwar on 14/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class CustomUIView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.red
        contentView.frame = contentView.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
