//
//  PhotoListViewController.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 11/26/23.
//second screen view controller

import Foundation
import UIKit
import CoreData // library connect with database
class PhotoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var photoListTableView: UITableView!
    
    @IBOutlet weak var photoSegment: UISegmentedControl!
    
    var photoList : [Photo]?
    var searchQuery = ""  // data from user type on input input box -- store here-then look line 28
    var showFavourite = false
    var favouritePhotoList: [PhotoEntity]?
    
    
    override func viewDidLoad() {
        photoListTableView.delegate = self
        photoListTableView.dataSource = self
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        if showFavourite == true{
            self.fetchPhoto()
            self.photoListTableView.reloadData()
        }else{
            self.getPhoto()
        }
        
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
    //fetch data from database
    func fetchPhoto(){
        let fetchRequest = PhotoEntity.fetchRequest()
        let photoList = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(fetchRequest)
        favouritePhotoList = photoList
    }
    @IBAction func photoSegmentAction(_ sender:UISegmentedControl) {
        //when secment 0 display all data- when segment one show favourite data
        if sender.selectedSegmentIndex == 0{
         //show all when false
            showFavourite = false
            self.photoListTableView.reloadData()
        }else{
            //else show only favourite
            showFavourite = true
            fetchPhoto()
            self.photoListTableView.reloadData()
        }
    }
    
}

extension PhotoListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showFavourite == true{
            return favouritePhotoList?.count ?? 0
        }
        return photoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell creation
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell
        if showFavourite == true{
        let photoData = favouritePhotoList?[indexPath.row] //which row ex row 0
            cell?.photoNameLabel.text = photoData?.name//alt come from photot medal
            cell?.photoIDLabel.text = photoData?.photoId
            cell?.favourite = photoData
        }else{
            //else show all data
            let photoData = photoList?[indexPath.row]
            cell?.photoNameLabel.text = photoData?.alt
            cell?.photoIDLabel.text = "\(photoData?.photographer_id ?? 0)"
            cell?.photoData = photoData
        }
      
        return cell!
        }
    //we make didselect function to know which row  the user select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath) as? PhotoTableViewCell
        if showFavourite == true{
            self.performSegue(withIdentifier: "connectDetail", sender: cell?.favourite)
            
        }else{
            
            self.performSegue(withIdentifier: "connectDetail", sender: cell?.photoData)
            //"connectDetail" come from connect detail from 3 screen to last screen --id -5 tab
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 
    }
    //prepare data from segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let deatilViewController = segue.destination as? PhotoDetailViewController
        if showFavourite == true{
            deatilViewController?.favouritePhotoObj = sender as? PhotoEntity
        }else{
            deatilViewController? .photoObject = sender as? Photo // where photoObject come from?
        }
       
    }
    //delete slide favourite
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return showFavourite
    }
    //what you what to do when edit ex flag delete or ?
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //what need to be done when editing happen
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //got the cell
            let cell = tableView.cellForRow(at: indexPath) as? PhotoTableViewCell
            //below alert box 137-151
            let alertController = UIAlertController(title: "Alert!", message: "Do you want to delete?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { _ in
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                   let photoObj = cell?.favourite {
                    appDelegate.persistentContainer.viewContext.delete(photoObj)
                    appDelegate.saveContext()
                    self.fetchPhoto()
                    self.photoListTableView.reloadData()
                    
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style:.default)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    }

