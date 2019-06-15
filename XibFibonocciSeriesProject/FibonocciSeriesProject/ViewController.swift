//
//  ViewController.swift
//  FibonocciSeriesProject
//
//  Created by Amirthy Tejeshwar on 14/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit


struct  Section {
    var name = "Heading"
    var listOfDoubles = [Double]()
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    var totalSections = 0
    var indexPathInClass = IndexPath()
    
    
    
    var dataSections = [Section]()
    var DoubleList = [Double]()
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.sectionHeaderHeight = 50
        //let sectionOne = Section(name: "Heading1", listOfDoubles: DoubleList)
        self.dataSections.append(Section(name: "Heading", listOfDoubles: getFibanocciList()))
        self.dataSections.append(Section(name: "Heading", listOfDoubles: getFibanocciList()))
        self.dataSections.append(Section(name: "Heading", listOfDoubles: getFibanocciList()))
        self.dataSections.append(Section(name: "Heading", listOfDoubles: getFibanocciList()))
        
        totalSections = 4
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSection = dataSections[section]
        //prDouble(dataSection)
        return dataSection.listOfDoubles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSections.count
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //if dataSections.count < 6 {
        if indexPaths[0].section < totalSections, indexPaths[0].section > totalSections-3  {
            addSections()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController = UIAlertController(title: "Hurray!", message: "You have selected the row \(indexPath.row) with value \(dataSections[indexPath.section].listOfDoubles[indexPath.row])", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataSection = dataSections[section]
        return dataSection.name+" \(section+1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? TableViewCell
        let text = dataSections[indexPath.section].listOfDoubles[indexPath.row]
        cell?.label.text = String(text)
        var returningCell = TableViewCell()
        if let singleCell = cell {
            returningCell = singleCell
        }
        return returningCell

    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        //inside collectionView they are different
//        tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerReuseIdentifier")
//    }

    func addSections() {
        dataSections.append(Section(name: "Heading", listOfDoubles: getFibanocciList()))
        totalSections = totalSections + 1
//            tableView.insertSections(IndexSet(integer: dataSections.count - 1), with: .automatic)
//            var reloadPaths = [IndexPath]()
//            (0..<tableView.numberOfRows(inSection: dataSections.count-1)).indices.forEach { rowIndex in
//                let indexPath = IndexPath(row: rowIndex, section: dataSections.count-1)
//                reloadPaths.append(indexPath)
//            }
//            tableView.reloadRows(at: reloadPaths, with: .top)
    }
    
    func getFibanocciList() -> [Double] {
        var i : Double, j: Double
        var newSection = [Double]()
        if dataSections.count > 0{
            let constant = dataSections[dataSections.count-1].listOfDoubles.count
            i = dataSections[dataSections.count-1].listOfDoubles[constant-2]
            j = dataSections[dataSections.count-1].listOfDoubles[constant-1]
            let temp  = i+j
            i = temp
            j = temp + j
        }
        else {
            i = 0
            j = 1
        }
        newSection.append(i)
        newSection.append(j)
        for _ in 1..<10 {
            let k = i+j
            newSection.append(k)
            i = j
            j = k
        }
        return newSection
    }
    
    
    

}

