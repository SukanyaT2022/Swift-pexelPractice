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
    var searchQuery = ""  // data from user type on input input box -- store here-then look line 28
    
    override func viewDidLoad() {
        photoListTableView.delegate = self
        photoListTableView.dataSource = self
        self.getPhoto()
    }
    //add from this line --call api here
    func getPhoto(){
        //below line make api call
        NetworkHelper().getPhoto(query:searchQuery) { result in
            switch result {
            case .success(let data):
                self.photoList = data
                DispatchQueue.main.async {
                    self.photoListTableView.reloadData()
                }
                //line32 to 34 reload refesh tabe view so screen appear
                DispatchQueue.main.async {
                    self.photoListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PhotoListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell creation
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell
        let photoData = photoList?[indexPath.row] //which row ex row 0
        cell?.photoNameLabel.text = photoData?.alt//alt come from photot medal
        cell?.photoIDLabel.text = String(photoData?.photographer_id ?? 0)
        
        cell?.photoData = photoData
        return cell!
        }
    //we make didselect function to know which row  the user select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath) as? PhotoTableViewCell
        self.performSegue(withIdentifier: "connectDetail", sender: cell?.photoData)
        //"connectDetail" come from connect detail from 3 screen to last screen --id -5 tab
    }
    }

