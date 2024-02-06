//
//  PhotoDetailViewController.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 1/5/24.
//

import Foundation
import UIKit
import CoreData
class PhotoDetailViewController: UIViewController{
    var photoObject: Photo?
    var favouritePhotoObj : PhotoEntity?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var photographerLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        
    }
    func displayData(){
        if photoObject != nil{
            titleLable.text = photoObject?.alt
            photographerLabel.text = photoObject?.photographer
            if let imagePath = photoObject?.src?.small{
                downloadImage(path: imagePath)
            }
            
        }else if favouritePhotoObj != nil{
            titleLable.text = favouritePhotoObj?.name
            photographerLabel.text =  favouritePhotoObj?.photographerName
            if let imagePath =  favouritePhotoObj?.imagePath{
                downloadImage(path: imagePath)
            }
        }
        updatedFavouriteButton()
    }
    func updatedFavouriteButton(){
        if favouritePhotoObj != nil{
            favouriteButton.backgroundColor = .gray
            favouriteButton.isUserInteractionEnabled = false
            return 
        }
        let fetchRequest = PhotoEntity.fetchRequest()
        let favouritePhotoList = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(fetchRequest)
        if let photoData = favouritePhotoList?.filter({$0.photoId == String(photoObject?.id ?? 0)}).first{
            favouriteButton.backgroundColor = .gray
            favouriteButton.isUserInteractionEnabled = false
        }
    }
    //next step-display function by download image
    //this func download on the last screen
    func downloadImage(path:String){
        if let url = URL(string:path){
            let task = URLSession.shared.dataTask(with: url) {data, response, error in
                if let data = data{
                    let image = UIImage(data:data)
                    DispatchQueue.main.async{
                        self.photoImageView.image = image
                        
                    }
                }
            }
            task.resume()
        }
        
    }
    //this fuction save image to data base
    @IBAction func favouriteButtonAction(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            //crate entity and save data
            let description = NSEntityDescription.entity(forEntityName: "PhotoEntity", in: context)
            let photoEntity = NSManagedObject(entity: description!, insertInto: context) as?
            PhotoEntity
            photoEntity?.photoId = String(photoObject?.id ?? 0)//photoObject line from line 12
            photoEntity?.name = photoObject?.alt
            photoEntity?.photographerName = photoObject?.photographer
            photoEntity?.imagePath = photoObject?.src?.small
            //line below save data from database
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
