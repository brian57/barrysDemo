//
//  ButtonWithImage.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/10/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {

    @IBInspectable var imageWidth: CGFloat = 0
    @IBInspectable var imageHeight: CGFloat = 0
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var bottomPadding: CGFloat = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            
            titleEdgeInsets = UIEdgeInsets(top: topPadding + imageWidth, left: 0, bottom: bottomPadding, right: 0)
            imageView!.layer.borderWidth = 1.0
            imageView!.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: (bounds.width - imageWidth) / 2.0  , y: topPadding, width: imageWidth, height: imageHeight)
    }


}
