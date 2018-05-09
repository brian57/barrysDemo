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
    @IBOutlet weak var segmentedControl: LocationControl!
    @IBOutlet weak var instructorsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Location Name"
        
        // customize search bar
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        if let textField = searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.subviews.first?.isHidden = true
            textField.layer.backgroundColor = UIColor.barrysLightGray.cgColor
            textField.layer.cornerRadius = 1
            textField.layer.masksToBounds = true
        }
        
        searchedInstructors = instructors
        let nib = UINib(nibName: "InstructorCollectionViewCell", bundle: nil)
        instructorsCollection.register(nib, forCellWithReuseIdentifier: cellReuseIdentifier)
    }


    @IBAction func segmentedControlValueChanged(_ sender: LocationControl) {
        if (sender.selectedSegmentIndex == 0 ) {
            instructorsView.isHidden = true
        } else {
            instructorsView.isHidden = false
        }
         sender.changeSelectedIndex(to: sender.selectedSegmentIndex)
        
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

