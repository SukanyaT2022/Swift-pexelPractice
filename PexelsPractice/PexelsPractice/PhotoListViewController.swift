//
//  PhotoListViewController.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 11/26/23.
//second screen view controller

import Foundation
import UIKit
class PhotoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var photoListTableView: UITableView!
    
    @IBOutlet weak var photoSegment: UISegmentedControl!
    
    var photoList : [Photo]?
    
    override func viewDidLoad() {
        photoListTableView.delegate = self
        photoListTableView.dataSource = self
    }
}
extension PhotoListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell
        let photoData = photoList?[indexPath.row] //which row ex row 0
        cell?.photoNameLabel.text = photoData?.alt//alt come from photot medal
        cell?.photoIDLabel.text = photoData?.photographer_id ?? ""
        return cell!
        }
    }

