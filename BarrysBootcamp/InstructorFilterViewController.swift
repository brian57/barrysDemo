//
//  InstructorFilterViewController.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/9/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

class InstructorFilterViewController: UIViewController,
      UITableViewDataSource, UITableViewDelegate
{

    var selectedCellIndex: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let countries: [String] = ["Canada", "Italy", "Norway", "Sweden", "United Arab Emirates", "United Kindgdom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // give segmented control hard corners
        segmentedControl.layer.cornerRadius = 0.0;
        segmentedControl.layer.borderColor = UIColor.barrysDarkGray.cgColor
        segmentedControl.layer.borderWidth = 1.0;
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.item
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = selectedCellIndex == indexPath.item ?
            "selectedCountryCell" :
            "deselectedCountryCell"
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = countries[indexPath.item]

        return cell
    }

}
