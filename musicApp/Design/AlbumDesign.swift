//
//  AlbumDesign.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/9/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit

@IBDesignable
class AlbumDesign: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }

}
