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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        sortedViews = self.subviews.sorted(by:{$0.frame.origin.x < $1.frame.origin.x})
        
        let borderColor = UIColor.barrysGray
        self.layer.cornerRadius = 0
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.tintColor = borderColor
        
        changeSelectedIndex(to: currentIndex)
        
        let unselectedAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray,
                                    NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        
        let selectedAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                    NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        self.setTitleTextAttributes(unselectedAttributes, for: .normal)
        self.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    func changeSelectedIndex(to newIndex: Int) {
        print("CHANGE SELECTED INDEX \(newIndex)")
        currentIndex = newIndex
    }

}
