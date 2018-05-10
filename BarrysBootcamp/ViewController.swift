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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    let numberOfItemsPerRow: CGFloat = 2.0
    let leftAndRightPaddings: CGFloat = 16.0
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var bottomNav: UIView!
    
    private let cellReuseIdentifier = "collectionCell"
    
    // instructors stub data
    var instructors: [Instructor] = [
        Instructor(name: "Britnney", image: "Image"),
        Instructor(name: "Chris", image: "Image-1"),
        Instructor(name: "Bryer", image: "Image-2"),
        Instructor(name: "Kelly", image: "Image"),
        Instructor(name: "Chris", image: "Image-1"),
        Instructor(name: "Bryer", image: "Image-2"),
        Instructor(name: "Britnney", image: "Image"),
        Instructor(name: "Chris", image: "Image-1"),
        Instructor(name: "Bryer", image: "Image-2")
    ]
    
    // current list of instructors shown in colection
    var searchedInstructors: [Instructor] = []

    @IBOutlet weak var instructorsCollection: UICollectionView!
    @IBOutlet weak var instructorsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var topTabsStack: UIStackView!
    @IBOutlet weak var tabsView: UIView!
    
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
        
        // add border
        topTabsStack.layer.borderWidth = 1.0
        topTabsStack.layer.borderColor = UIColor.red.cgColor
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
                print("STUDIOS CLICKED")
                instructorsView.isHidden = true
            case "Instructors":
                instructorsView.isHidden = false
                print("INSTRUCTORS CLICKED")
            default:
                print("DEFAULT CLICKED")
            }
        }

    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedInstructors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = instructorsCollection.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! InstructorCollectionViewCell

        cell.setName(name: searchedInstructors[indexPath.item].name)
        cell.setImage(name: searchedInstructors[indexPath.item].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (screenSize.width - leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width + 20)
    }
    


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

