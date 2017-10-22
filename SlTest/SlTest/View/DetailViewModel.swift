//
//  detailTempViewModel.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import Foundation
typealias viewmodelImageSucces = (_ data : Data?)->()
typealias viewmodelImagefaillure = (_ data : Error?)->()

protocol viewModelProtocol {
     var day : String? {get}
     var min : String? {get}
     var max : String? {get}
     var night : String? {get}
     var eve : String? {get}
     var morn : String? {get}
    
     var main : String? {get}
     var WeatherDesc : String? {get}
     var icon : String? {get}
    
    func iconImage(success: viewmodelImageSucces?, faiullure: viewmodelImagefaillure?)
}
struct DetailViewModel: viewModelProtocol {
    
    var day : String?
    var min : String?
    var max : String?
    var night : String?
    var eve : String?
    var morn : String?
    
    var main : String?
    var WeatherDesc :String?
    var icon : String?
    
    func iconImage(success: viewmodelImageSucces?, faiullure: viewmodelImagefaillure?) {
     
        guard let icon = self.icon else {
         return
        }
        
        let url = API.ResourcePath.Icon.path + icon + ".png"
        ImageDownloadManager.sharedInstance.loadImage(FromUrl: url, success: { (data) in
            if let data = data as? Data , let success = success {
                success(data)
            }
        }) { (error) in
            print(error)
        }
       
    
    }
    
    init(withForecast  forecastItem : Forecast) {
        
        if let weather = forecastItem.weather , let weatherItem = weather.first  {
            main =  weatherItem.main
            WeatherDesc = weatherItem.description
            icon = weatherItem.icon
        }
        if let temp = forecastItem.temp  {
            day = String(describing :temp.day)
            min = String(describing : temp.min)
            max = String(describing : temp.max)
            night = String(describing : temp.night)
            eve =  String(describing :temp.eve)
            morn =  String(describing :temp.morn)
            
            
        }
    }
}
