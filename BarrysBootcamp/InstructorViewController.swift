//
//  InstructorViewController.swift
//  BarrysBootcamp
//
//  Created by Brian Stewart on 5/10/18.
//  Copyright © 2018 Brian Stewart. All rights reserved.
//

import UIKit

class InstructorViewController: UIViewController,
    UITableViewDataSource, UITableViewDelegate
{

    var classes: [String] = ["Chest,Back,Abs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)

        return cell
    }
}
