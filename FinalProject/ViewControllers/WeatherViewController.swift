//
//  WeatherViewController.swift
//  FinalProject
//
//  Created by Kevin Kim on 2019-11-27.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func unwindToWeatherViewController(segue: UIStoryboardSegue) {
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var dictionary = [[String:String]]()
    
    let OntarioCities: [String] = ["Barrie","Belleville","Brampton","Brant","Brantford","Brockville","Burlington","Cambridge","Clarence-Rockland","Cornwall","Dryden","Elliot Lake","Greater Sudbury","Guelph","Haldimand County","Hamilton","Kawartha Lakes","Kenora","Kingston","Kitchener","London","Markham","Mississauga","Niagara Falls","Norfolk County","North Bay","Orillia","Oshawa","Ottawa","Owen Sound","Pembroke","Peterborough","Pickering","Port Colborne","Prince Edward County","Quinte West","Richmond Hill","Sarnia","Sault Ste. Marie","St. Catharines","St. Thomas","Stratford","Temiskaming Shores","Thorold","Thunder Bay","Timmins","Toronto","Vaughan","Waterloo","Welland","Windsor","Woodstock"]
    
    let APPID: String = "&appid=03c79c2a3f1c41eff2c3f7d8a726ce4e"
    let urlString: String = "https://api.openweathermap.org/data/2.5/weather?q="

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
     
    }
    

    
    // table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OntarioCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = OntarioCities[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate

        mainDelegate.cityName = OntarioCities[indexPath.row]
        
        self.performSegue(withIdentifier: "segueWeather", sender: nil)
    }
    

}
