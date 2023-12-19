//
//  PhotoModel.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 11/9/23.
//

import Foundation
struct PhotoResponse: Codable{
    var page:Int?
    var per_page: Int?
    var total_results: Int?
    var next_page: String?
    var prev_page: String?
    var photos: [Photo]?
}
struct Photo:Codable{
    var id: Int?
    var width: Int?
    var height: Int?
    var url : String?
    var photographer: String?
    var photographer_url: String?
    var photographer_id: String?
    var avg_color: String?
    var src: Source?
    var liked: Bool?
    var alt: String?

}
struct Source: Codable{
    var original: String?
    var large2x: String?
    var large: String?
    var medium: String?
    var small: String?
    var portrait: String?
    var landscape: String?
    var tiny: String?
}


//{
//  "page": 2,
//  "per_page": 40,
//  "total_results": 8000,
//  "next_page": "https://api.:.com/v1/curated?page=3&per_page=40",
//  "prev_page": "https://api.pexels.com/v1/curated?page=1&per_page=40"
//}



//{
//  "page": 1,
//  "per_page": 1,
//  "photos": [
//    {
//      "id": 2880507,
//      "width": 4000,
//      "height": 6000,
//      "url": "https://www.pexels.com/photo/woman-in-white-long-sleeved-top-and-skirt-standing-on-field-2880507/",
//      "photographer": "Deden Dicky Ramdhani",
//      "photographer_url": "https://www.pexels.com/@drdeden88",
//      "photographer_id": 1378810,
//      "photographer_id": "#7E7F7B",
//      "src": {
//        "original": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg",
//        "large2x": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
//        "large": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
//        "large": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=350",
//        "small": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=130",
//        "portrait": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
//        "landscape": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
//        "tiny": "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
//      },
//      "liked": false,
//      "alt": "Brown Rocks During Golden Hour"
//    }
//  ],
//  "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=1"
//}
