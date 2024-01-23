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
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var photographerLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        
    }
    func displayData(){
        titleLable.text = photoObject?.alt
        photographerLabel.text = photoObject?.photographer
        if let imagePath = photoObject?.src?.small{
         downloadImage(path: imagePath)
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
            photoEntity?.photoId = String(photoObject?.photographer_id ?? 0)//photoObject line from line 12
            photoEntity?.name = photoObject?.alt
            photoEntity?.photographerName = photoObject?.photographer
            photoEntity?.imagePath = photoObject?.src?.small
            //line below save data from database
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
}
