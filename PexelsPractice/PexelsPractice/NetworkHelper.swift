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
    
    func getPhoto(query:String, completion:@escaping(Result<[Photo]?, Error>)->Void){
        baseUrl.append(query)// this line is search keyword
        let urlObj = URL(string:baseUrl)
        var request = URLRequest(url:urlObj!)//url is parameter and urlObj! from line 14
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")//apiKey line11//        make authorization request
    //process request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print(error)
                completion(.failure(error))//completion send data to source function from photos get call
            }else{
                if let data = data{
                    let json = try? JSONSerialization.jsonObject(with: data) as?[String:Any]
                    print(json)
                    let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: data)//data line 24
                    print(json)
                    completion(.success(photoResponse?.photos))//photos comefrom photoModel line 15
                }
            }
        }
        task.resume() //execute it after create a task
    }
    }


//curl -H "Authorization: c19t5LBUeXItCyO5nb5bpds50rtTKwmX7xOeFa4PnEBN8jabAxpjQW6U" \
//  "https://api.pexels.com/v1/search?query=nature&per_page=1"
