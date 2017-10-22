//
//  weatherCollectionViewCell.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 22/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class weatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pressure : UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var speed  : UILabel!
    @IBOutlet var deg : UILabel!
    @IBOutlet var clouds : UILabel!
    
    override func awakeFromNib() {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    }
    
    
    var forecastItem : ForecastItem? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        guard let forecastItem = forecastItem else {
            return
        }
        pressure.text = String(describing: forecastItem.pressure)
        humidity.text = String(describing: forecastItem.humidity)
        speed.text = String(describing: forecastItem.speed)
        deg.text = String(describing: forecastItem.deg)
        clouds.text = String(describing: forecastItem.clouds)
    }
}
