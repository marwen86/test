//
//  viewPresenter.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
let url = "http://api.openweathermap.org/data/2.5/forecast/daily?q=paris&mode=Json&units=metric&cnt=16&appid=b1938b15024d33334163ef66c06849aa"
let imageUrl = "http://openweathermap.org/img/w/02d.png"

class viewPresenter: NSObject {
    
    weak var view : ViewProtocol!
    
    init(withView view: ViewProtocol ) {
        self.view = view
    }
    func  loadweatherData() {
        let url = API.ResourcePath.Forecast.forecastpath
        DownloadDataManager.sharedInstance.loadData(fromUrl: url, success: { (json) in
            print(json)
            //parseJson
            let list = Forecast.parseForecast(json: json)
            print("coool")
            self.view?.refreshView(listForecast: list)
            
        }) { (error) in
            
        }
    }
}

extension Temp {
    
    static func parsetemp(data : Dictionary<String , AnyObject>) -> Temp? {
        
        guard let day = data["day"] as? Double,
            let min = data["min"] as? Double,
            let max = data["max"] as? Double,
            let night = data["night"] as? Double,
            let eve = data["eve"] as? Double,
            let morn = data["morn"] as? Double  else {
                return nil
                
        }
        return Temp(day: day, min: min, max: max, night: night, eve: eve, morn: morn)
    }
}

extension Forecast {
   static func parseForecast(json : Dictionary<String , AnyObject>)-> [Forecast]? {
        var result = [Forecast]()
        if let list = json["list"] as? Array<AnyObject> {
            for item in list {
                guard let item = item as? Dictionary<String,AnyObject> ,
                    let pressure = item["pressure"] as? Double,
                    let humidity = item["humidity"] as? Int,
                    let speed = item["speed"] as? Double,
                    let deg = item["deg"] as? Int,
                    let clouds = item["clouds"] as? Int,
                    let dt = item["dt"] as? Int,
                    let tempData = item["temp"] as? Dictionary<String,AnyObject>,
                    let tempItem = Temp.parsetemp(data: tempData),
                    let weatherData = item["weather"] as? Array<AnyObject>,
                    let listWeather = Weather.parseWeather(data: weatherData) else{
                        return nil
                }
                
                let forecast = Forecast(dt: dt, temp: tempItem, pressure: pressure, humidity: humidity, weather: listWeather, speed: speed, deg: deg, clouds: clouds)
                result.append(forecast)
            }
            
        }
        return result
        
        
        
    }
}
extension Weather {
    
    static func parseWeather(data : Array<AnyObject>) -> [Weather]? {
        var listWeather = [Weather]()
        for item in data {
            guard let item = item as? Dictionary<String,AnyObject>,
                let id = item["id"] as? Int,
                let main = item["main"] as?  String,
                let description = item["description"] as?  String,
                let icon = item["icon"] as?  String else {
                    return nil
            }
            let weatherItem = Weather(id: id, main: main, description: description, icon: icon)
            listWeather.append(weatherItem)
        }
        return listWeather
    }
}

