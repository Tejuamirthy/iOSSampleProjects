//
//  ViewController.swift
//  UrlImageSampleProject
//
//  Created by Amirthy Tejeshwar on 17/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let urlString = "https://scubasanmateo.com/images/smiley-clipart-square-2.jpg"
    let urlString2 = "https://timesofindia.indiatimes.com/thumb/msid-69820059,imgsize-152681,width-400,resizemode-4/69820059.jpg"
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlString2) else { return }
        //let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: url, completionHandler: { (dataOptional, urlResponse, error) in
            guard error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: dataOptional!)
            }
        }).resume()
//
//        let url = URL(string: urlString2)
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//            if error != nil
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.imageView.image = UIImage(data: data!)
//            }
//        }).resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

