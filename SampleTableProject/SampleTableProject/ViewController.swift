//
//  ViewController.swift
//  SampleTableProject
//
//  Created by Amirthy Tejeshwar on 13/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

struct section {
    var name: String
    var elements: [Int]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...30 {
            data.append("\(i)")
        }
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: "Hint", message:
            "You have selected the row - \(indexPath.row)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? CustomTableViewCell
        let text = data[indexPath.row]
        cell?.label.text = text
        var returningCell = CustomTableViewCell()
        if let singleCell = cell {
            returningCell = singleCell
        }
        return returningCell
    }
}

