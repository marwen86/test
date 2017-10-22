//
//  File.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import Foundation
struct Forecast {
    var dt : Int
    var temp : Temp?
    var pressure : Double
    var humidity: Int
    var weather : [Weather]?
    var speed : Double
    var deg : Int
    var clouds : Int
    
}
