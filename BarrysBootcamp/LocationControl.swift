//
//  LocationControl.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/8/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

class LocationControl: UISegmentedControl {

    var sortedViews: [UIView]!
    var currentIndex: Int = 1
    let unselectedAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray,
                                NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
    
    let selectedAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                              NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        sortedViews = self.subviews.sorted(by:{
            print("frameOriginX $0 = \($0.frame.origin.x)")
            print("frameOriginX $1 = \($1.frame.origin.x)")
            return $0.frame.origin.x < $1.frame.origin.x
        })
        
//        self.isMomentary = true
        let borderColor = UIColor.barrysGray
        self.layer.cornerRadius = 0
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.tintColor = borderColor
        
        changeSelectedIndex(to: currentIndex)
        


//        self.setTitleTextAttributes(unselectedAttributes, for: .normal)
//        self.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    func changeSelectedIndex(to newIndex: Int) {
        sortedViews = self.subviews.sorted(by:{
            return $0.frame.origin.x < $1.frame.origin.x
        })
        
        print("NEW INDEX = \(newIndex) CURRENT INDEX = \(currentIndex)")
        
        currentIndex = newIndex
        self.selectedSegmentIndex = UISegmentedControlNoSegment
        
        sortedViews[currentIndex].backgroundColor = UIColor.white
        let subview = sortedViews[currentIndex]

        for sub in subview.subviews {
            if let sub = sub as? UILabel {
                let myAttrString = NSAttributedString(string: sub.text!, attributes: selectedAttributes)
                sub.attributedText = myAttrString
               print("LABEL = \(sub.text)")
            }
        }

    }

}
