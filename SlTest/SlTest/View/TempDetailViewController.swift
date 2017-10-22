//
//  TempDetailViewController.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class TempDetailViewController: UIViewController {

    
    @IBOutlet var day : UILabel!
    @IBOutlet var min : UILabel!
    @IBOutlet var max : UILabel!
    @IBOutlet var night : UILabel!
    @IBOutlet var eve : UILabel!
    @IBOutlet var morn : UILabel!
    
    @IBOutlet var main : UILabel!
    @IBOutlet var WeatherDesc : UILabel!
    @IBOutlet var icon : UILabel!
    
    @IBOutlet weak var image: UIImageView!
   
    var viewModel  : viewModelProtocol?
    {
        didSet {
            updateView()
        }
    }
    
    var forecastItem: Forecast?

    func updateView() {
        if !isViewLoaded {
            return
        }
        day.text = viewModel?.day
        min.text = viewModel?.min
        max.text = viewModel?.max
        night.text = viewModel?.night
        eve.text =  viewModel?.eve
        morn.text =  viewModel?.morn
 
        main.text = viewModel?.main
        WeatherDesc.text = viewModel?.WeatherDesc
        icon.text = viewModel?.icon
        viewModel?.iconImage(success: { (data) in
            guard let data = data else {
              return
            }
            
            self.image.image = UIImage(data: data)
        }, faiullure: { (error) in
            
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let forecastItem = forecastItem else {
          return
        }
        self.viewModel = DetailViewModel(withForecast: forecastItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
