//
//  ViewController.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/8/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

struct Instructor {
    var name: String
    var image: String
}

class ViewController: UIViewController {
    let numberOfItemsPerRow: CGFloat = 2.0
    let leftAndRightPaddings: CGFloat = 40.0
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var bottomNav: UIView!
    
    let cellReuseIdentifier = "collectionCell"
    
    // instructors stub data
    var instructors: [Instructor] = [
        Instructor(name: "Alycia", image: "Alycia"),
        Instructor(name: "Chris", image: "Image-1"),
        Instructor(name: "Jake G", image: "JakeG"),
        Instructor(name: "Josey", image: "Josey"),
        Instructor(name: "Alycia", image: "Alycia"),
        Instructor(name: "Chris", image: "Image-1"),
        Instructor(name: "Jake G", image: "JakeG"),
        Instructor(name: "Josey", image: "Josey")
    ]
    
    // current list of instructors shown in collection view
    var searchedInstructors: [Instructor] = []

    @IBOutlet weak var instructorsCollection: UICollectionView!
    @IBOutlet weak var instructorsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var topTabsStack: UIStackView!
    @IBOutlet weak var tabsView: UIView!
    @IBOutlet weak var findAClass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Location Name"
        bottomNav.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        bottomNav.layer.borderWidth = 1.0

        // change color of filterButton
        let filterImg = UIImage(named: "slider")
        let tintedImg = filterImg?.withRenderingMode(.alwaysTemplate)
        filterButton.setImage(tintedImg, for: .normal)
        filterButton.setImage(tintedImg, for: .highlighted )
        filterButton.tintColor = UIColor.barrysDarkGray
        
        tabsView.layer.borderColor = UIColor.barrysGray.cgColor
        tabsView.layer.borderWidth = 1.0
        
        navigationController?.navigationBar.shadowImage = UIImage()

        // customize search bar
        if let textField = searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.subviews.first?.isHidden = true
            textField.layer.backgroundColor = UIColor.barrysLightGray.cgColor
            textField.layer.cornerRadius = 1
            textField.layer.masksToBounds = true
        }
        
        searchedInstructors = instructors
        let nib = UINib(nibName: "InstructorCollectionViewCell", bundle: nil)
        instructorsCollection.register(nib, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        // bind tab buttons to tabClicked() method
        for subview in topTabsStack.subviews {
            if let button = subview as? UIButton {
                button.addTarget(self, action: #selector(tabClicked(_:)), for: .touchUpInside)
            }
        }
        
    }
    
    // handle buttons at top of page being clicked
    @objc func tabClicked(_ sender: UIButton) {
        // update styling
        for subview in topTabsStack.subviews {
            if let button = subview as? UIButton {
                var color = UIColor.gray
                if button == sender {
                    color = UIColor.black
                }
                
                button.setTitleColor(color, for: .normal)
            }
        }
        
        if let title = sender.titleLabel?.text {
            switch(title) {
            case "Studios":
                instructorsView.isHidden = true
            case "Instructors":
                instructorsView.isHidden = false
            default:
                print("DEFAULT CLICKED")
            }
        }

    }
    
    @IBAction func unwindToInstructors(sender: UIStoryboardSegue) {
        // TODO add code to deal with return segue from filter page
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedInstructors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = instructorsCollection.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! InstructorCollectionViewCell
        
        cell.setName(name: searchedInstructors[indexPath.item].name)
        cell.setImage(name: searchedInstructors[indexPath.item].image)
        
        return cell
    }
    

}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jumpToInstructor", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (screenSize.width - leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width + 20)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}

extension ViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            searchedInstructors = instructors
        } else {
            searchedInstructors = instructors.filter {
                print($0.name.lowercased())
                return $0.name.lowercased().range(of:searchText.lowercased()) != nil
            }
        }
        instructorsCollection.reloadData()
    }
}

class CustomView: UIView {
    @IBInspectable var widthRatio: CGFloat = 1.0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: widthRatio, height: 1)
    }
}
