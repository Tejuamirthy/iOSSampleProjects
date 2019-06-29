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
    
    var dictionaryOfEditedRows = [Int:Int]()
    
    var listOfImages: [UIImage] = []
    let urlString = "https://timesofindia.indiatimes.com/thumb/msid-69820059,imgsize-152681,width-400,resizemode-4/69820059.jpg"
    let headerViewIdentifier = "HeaderViewIdentifier"
    let tableCellIdentifier = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    
        navigationItem.rightBarButtonItem = editButtonItem
        //enable reordering the rows: Step -1
        //tableView.isEditing = true
        //navigationItem.rightBarButtonItem = editButtonItem
        //enable swipe to delete: Step-1
        tableView.allowsSelectionDuringEditing = true
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: Bundle.main), forCellReuseIdentifier: tableCellIdentifier)
        tableView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // Takes care of toggling the button's title.
        super.setEditing(!isEditing, animated: true)
        
        // Toggle table view editing.
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    //enable reordering the rows: Step -2.1
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //enable reordering the rows: Step -2.1
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    //enable reordering the rows: Step-3
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.listOfNumbers[getArrayIndexFromIndexPath(indexPath: sourceIndexPath)]
//        listOfNumbers.remove(at: getArrayIndexFromIndexPath(indexPath: sourceIndexPath))
//        dictionaryOfEditedRows[sourceIndexPath.section] = (dictionaryOfEditedRows[sourceIndexPath.section] ?? 5) - 1
        
        let deleteElementFlag = deleteFromArray(indexPath: sourceIndexPath)
        //tableView.deleteRows(at: [indexPath], with: .fade)
        listOfNumbers.insert(movedObject, at: getArrayIndexFromIndexPath(indexPath: destinationIndexPath))
        dictionaryOfEditedRows[destinationIndexPath.section] = (dictionaryOfEditedRows[destinationIndexPath.section] ?? 5) + 1
        if let flag = deleteElementFlag {
            tableView.beginUpdates()
            tableView.deleteSections(IndexSet(integer: flag)
                , with: .fade)
            //IndexSet(indexPath)
            dictionaryOfEditedRows.removeValue(forKey: sourceIndexPath.section)
            reduceKeyValueRows(section: sourceIndexPath.section)
            tableView.endUpdates()
        }
        //tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryOfEditedRows[section] ?? 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var number = 0
        var values = 0
        for key in dictionaryOfEditedRows {
            number = number + 1
            values = values + key.value
        }
        return number + (listOfNumbers.count - values)/5
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

    //this method is called just before the cell is going to be displayed **** important point is that willDisplay is called after cellRowAt
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let indexNumberInArray: Int = getArrayIndexFromIndexPath(indexPath: indexPath)
        if listOfNumbers.count <= indexNumberInArray {
            appendToList(indexPath: indexPath)
        } else {
            (cell as? TableViewCell)?.label.text = "\(listOfNumbers[indexNumberInArray])"
        }
    }
    
    func getArrayIndexFromIndexPath(indexPath: IndexPath) -> Int {
        var indexNumberInArray = 0
        for i in 0..<indexPath.section {
            indexNumberInArray = indexNumberInArray + (dictionaryOfEditedRows[i] ?? 5)
        }
        indexNumberInArray = indexNumberInArray + indexPath.row
        return indexNumberInArray
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
        let alertController = UIAlertController(title: "Do you wish to continue", message: "Please select your answer to move forward", preferredStyle: .actionSheet)
        let alertActionOK = UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in
            print("TODO implement how to delete this row")
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertActionOK)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    //enable swipe to delete: Step-2
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //enable swipe to delete: Step-3
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.beginUpdates()
            
            let deleteElementFlag = deleteFromArray(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let flag = deleteElementFlag {
                tableView.deleteSections(IndexSet(integer: flag)
                    , with: .fade)
                //IndexSet(indexPath)
                dictionaryOfEditedRows.removeValue(forKey: indexPath.section)
                reduceKeyValueRows(section: indexPath.section)
            }
            tableView.endUpdates()
            print("Deleted the row on swipe")
        }
    }
    
    func deleteFromArray(indexPath: IndexPath) -> Int? {
        var deleteElementOrNil: Int? = nil
        let temp = dictionaryOfEditedRows[indexPath.section] ?? 5
        dictionaryOfEditedRows[indexPath.section] = temp - 1
        if dictionaryOfEditedRows[indexPath.section] == 0 {
            deleteElementOrNil = indexPath.section
        }
        listOfNumbers.remove(at: getArrayIndexFromIndexPath(indexPath: indexPath))
        return deleteElementOrNil
    }
    
    func reduceKeyValueRows(section: Int) {
        for entry in dictionaryOfEditedRows {
            if section < entry.key {
                dictionaryOfEditedRows.removeValue(forKey: entry.key)
                dictionaryOfEditedRows[entry.key - 1] = entry.value
            }
        }
    }
//    
//    func alertBox(title: String, message: String){
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .)
//    }
    
    func appendToList(indexPath: IndexPath) {
        if listOfNumbers.count - 10 <= getArrayIndexFromIndexPath(indexPath: indexPath){
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

