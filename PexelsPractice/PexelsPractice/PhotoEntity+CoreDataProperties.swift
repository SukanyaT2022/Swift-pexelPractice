//
//  PhotoEntity+CoreDataProperties.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 1/18/24.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var name: String?
    @NSManaged public var photographerName: String?
    @NSManaged public var photoId: String?

}

extension PhotoEntity : Identifiable {

}
