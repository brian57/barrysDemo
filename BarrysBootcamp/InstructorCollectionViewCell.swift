//
//  InstructorCollectionViewCell.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/8/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

class InstructorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.text = "Instructor Name"
    }
    
    func setName(name: String) {
        self.name.text = name
    }
    
    func setImage(name: String) {
        let instImage = UIImage(named: name)
        image.image = instImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
