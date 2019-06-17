//
//  ViewController.swift
//  ArrayDataTableViewSampleProject
//
//  Created by Amirthy Tejeshwar on 17/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listOfNumbers: [Double] = {
        var array: [Double] = []
        var i: Double = 0
        var j: Double = 1
        array.append(i)
        array.append(j)
        for _ in 0..<20 {
            var temp = i + j
            array.append(temp)
            i = j
            j = temp
        }
        return array
    }()
    
    
    var listOfImages: [UIImage] = []
    let urlString = "https://timesofindia.indiatimes.com/thumb/msid-69820059,imgsize-152681,width-400,resizemode-4/69820059.jpg"
    let headerViewIdentifier = "HeaderViewIdentifier"
    let tableCellIdentifier = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: Bundle.main), forCellReuseIdentifier: tableCellIdentifier)
        tableView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections: Int
        if listOfNumbers.count%5 != 0 {
            numberOfSections = listOfNumbers.count/5 + 1
        } else {
            numberOfSections = listOfNumbers.count/5
        }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewOptional = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as? HeaderView
        headerViewOptional?.label.text = "Section-\(section+1)"
        if section < listOfImages.count {
            headerViewOptional?.leftImageView.image = listOfImages[section]
            headerViewOptional?.rightImageView.image = listOfImages[section]
        }
        //headerViewOptional?.rightImageView.image = listOfImages[section]
        return headerViewOptional
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewOptional = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier) as? TableViewCell
        guard let cellView = cellViewOptional else { return UITableViewCell() }
        return cellView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentIndexOfList = indexPath.section*5 + indexPath.row
        if listOfNumbers.count <= currentIndexOfList {
            appendToList(indexPath: indexPath)
        } else {
            (cell as? TableViewCell)?.label.text = "\(listOfNumbers[currentIndexOfList])"
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.section > listOfImages.count - 3{
                guard let url = URL(string: urlString) else { return }
                URLSession.shared.dataTask(with: url, completionHandler: { (dataOptional, urlResponse, error) in
                    guard error == nil, let data = dataOptional else { return }
                    DispatchQueue.main.async {
                        self.listOfImages.append(UIImage(data: data) ?? UIImage())
                    }
                }).resume()
            }
            appendToList(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to deselect the row so that it goes away after selecting the row
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController = UIAlertController(title: "Do you wish to continue", message: "Please select your answer to move forward", preferredStyle: .alert)
        let alertActionOK = UIAlertAction(title: "Continue", style: .destructive) { (UIAlertAction) in
            print("TODO implement how to delete this row")
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertActionOK)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func appendToList(indexPath: IndexPath) {
        if listOfNumbers.count - 10 <= indexPath.section*5 + indexPath.row {
            let nextInSeries = listOfNumbers[listOfNumbers.count-1] + listOfNumbers[listOfNumbers.count-2]
            listOfNumbers.append(nextInSeries)
            tableView.reloadData()
        }
    }

}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
}

