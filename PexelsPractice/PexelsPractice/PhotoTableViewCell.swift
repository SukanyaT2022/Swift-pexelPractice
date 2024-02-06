//
//  PhotoTableViewCell.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 12/16/23.
//

import Foundation
import UIKit
class PhotoTableViewCell:UITableViewCell{
    
    var photoData : Photo?
    var favourite : PhotoEntity?
    
    @IBOutlet weak var photoNameLabel: UILabel!
    
    @IBOutlet weak var photoIDLabel: UILabel!
    
}
