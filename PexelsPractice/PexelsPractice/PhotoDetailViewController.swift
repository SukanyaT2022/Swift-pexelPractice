//
//  PhotoDetailViewController.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 1/5/24.
//

import Foundation
import UIKit
class PhotoDetailViewController: UIViewController{
    var photoObject: Photo?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var photographerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func displayData(){
        titleLable.text = photoObject?.alt
        photographerLabel.text = photoObject?.photographer
        
    }
}
