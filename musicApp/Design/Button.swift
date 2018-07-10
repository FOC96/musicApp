//
//  Button.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/8/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.backgroundColor = UIColor(red:1.000000, green:1.000000, blue:1.000000, alpha:0.05).cgColor
    }
    
    

}
