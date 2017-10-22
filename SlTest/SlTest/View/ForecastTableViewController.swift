//
//  ForecastTableViewController.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 21/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit


protocol ViewProtocol : class{
    func refreshView(listForecast list: [ForecastItem]?)
}


extension ForecastTableViewController {
    func refreshView(listForecast list: [ForecastItem]?){
        self.forecastList = list
        self.tableView.reloadData()
    }
}

class ForecastTableViewController: UITableViewController, ViewProtocol {

    var forecastList : [ForecastItem]?
    var presenter : viewPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = viewPresenter(withView: self)
        presenter?.loadweatherData()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 255
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let forecastList = forecastList  else {
            return 0
        }
        return forecastList.count
    }

    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let forecastList = forecastList  else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        cell.forecastItem = forecastList[indexPath.row]
        return cell
    }
    
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let forecastList = forecastList  else {
            return
            
        }
        let selectedItem = forecastList[indexPath.row]
        performSegue(withIdentifier: "TempDetailViewController", sender: selectedItem)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier , identifier == "TempDetailViewController" , let des = segue.destination as? TempDetailViewController , let sender = sender as? ForecastItem{
           des.forecastItem = sender
        }
    }
    
 

}
