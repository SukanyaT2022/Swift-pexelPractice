//
//  NetworkHelper.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 11/8/23.
//

import Foundation
class NetworkHelper {
    var apiKey = "c19t5LBUeXItCyO5nb5bpds50rtTKwmX7xOeFa4PnEBN8jabAxpjQW6U"
    var baseUrl = "https://api.pexels.com/v1/search?query="
    func getPhoto(query:String){
        baseUrl.append(query)// this line is search keyword
        let urlObj = URL(string:baseUrl)
        var request = URLRequest(url:urlObj!)//url is parameter and urlObj! from line 14
        request.httpMethod = "GET"
        
//        make authorization request
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")//apiKey line11
    }
}

//curl -H "Authorization: c19t5LBUeXItCyO5nb5bpds50rtTKwmX7xOeFa4PnEBN8jabAxpjQW6U" \
//  "https://api.pexels.com/v1/search?query=nature&per_page=1"
