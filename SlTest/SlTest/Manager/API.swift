//
//  API.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import Foundation
typealias APIRequestResponse = (Data?, URLResponse?, Error?) -> ()
struct API {
    
    private struct Constants {
        static let APPID = "6a700a1e919dc96b0a98901c9f4bec47"
        static let baseURL = "http://api.openweathermap.org/"
    }
    
    enum ResourcePath: String {
        case Forecast = "data/2.5/forecast/daily?q=paris&mode=Json&units=metric&cnt=16&appid="
        case Icon = "img/w/"
    
        var path: String {
            return Constants.baseURL + rawValue
        }
        
        var forecastpath: String {
            return Constants.baseURL + rawValue + Constants.APPID
        }
    }
    
    static func loadData(fromUrl url:String? , response : @escaping APIRequestResponse) {
        
        guard let url  = url ,  let requestURL = URL(string: url) else {
            return
        }
        let urlRequest = URLRequest(url: requestURL)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: response)
        task.resume()
    }
    
    static func login_now(username:String, password:String , url : String? , response: @escaping APIRequestResponse) {
    
        guard let url  = url ,  let requestURL = URL(string: url) else {
            return
        }
        let urlRequest = NSMutableURLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        let dict = ["username" : username,
                    "password" : password]
        
        var paramString = ""
        for (key,value) in dict {
          paramString += key + "=" + value + "&"
        }
        urlRequest.httpBody = paramString.data(using: String.Encoding.utf8)
       
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: response)
        task.resume()
       
    
    }
}


