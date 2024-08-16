//
//  MoreImagesTableViewController.swift
//  CleverTapSDKTest
//
//  Created by Bhawanisingh Rao on 16/08/24.
//

import UIKit

class MoreImagesTableViewController: UITableViewController {
    
    var images = [UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MoreImagesTableViewCell", bundle: .main), forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoreImagesTableViewCell
        if let image = images[indexPath.row] {
            cell.imgView.image  = image
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
