//
//  ForecastTableViewCell.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var pressure : UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var speed  : UILabel!
    @IBOutlet var deg : UILabel!
    @IBOutlet var clouds : UILabel!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
