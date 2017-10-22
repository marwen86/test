
//
//  DownloadDataManager.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import Foundation
typealias DownloadDataResponse = (_ data: Dictionary<String , AnyObject>) ->()
typealias DownloadDataFaillure = (_ error : Error)-> ()
typealias ImageDownloadManagerResponse = (_ data : AnyObject?)->()

class DownloadDataManager {
    
    static let sharedInstance = DownloadDataManager()
    
    func loadData(fromUrl url :String, success : DownloadDataResponse? ,faillure : DownloadDataFaillure?) {
        API.loadData(fromUrl: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                // get data
                
                if let data = data, let json = try! JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String , AnyObject> {
                    if let success = success {
                        success(json)
                    }
                }
                return
            }
            
            if let error = error {
                //manage error
                if let faillure = faillure {
                 faillure(error)
                }
            }
        }
    }
}


class ImageDownloadManager{
   
   static let sharedInstance = ImageDownloadManager()
   
    let imageCache = NSCache<NSString, AnyObject>()
    
    func loadImage(FromUrl url:String , success : ImageDownloadManagerResponse? , faillure: DownloadDataFaillure?) {
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            if let success = success {
                success(cachedImage)
            }
        } else {
            API.loadData(fromUrl: url) { (data, response, error) in
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    // get data
                    
                    if let data = data  {
                        self.imageCache.setObject(data as AnyObject, forKey: url as NSString)
                        if let success = success {
                           success(data as AnyObject)
                        }
                    }
                    return
                }
                
                if let error = error {
                    if let faillure = faillure {
                     faillure(error)
                    }
                    
                }
                
            }
        }
       
    }
}
