//
//  HolidayViewController.swift
//  FinalProject
//
//  Created by Kevin Kim on 2019-11-27.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HolidayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textCountryCode: UITextField!
    
    
    let urlString: String = "https://holidayapi.com/v1/holidays?pretty&key="
    let APIKey: String = "44e17311-7056-47c6-9c7c-bc86163ae2c4"
    let countryQuery: String = "&country="
    let country: String = ""
    let yearQuery: String = "&year="
    let year: String = "2018"
    var urlString1: String = ""
    var countryCode: String = ""
    
    var holidayNames: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    
    @IBAction func unwindToHolidayViewController(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.urlString1 = urlString + APIKey + countryQuery
        
    }
    
    @IBAction func searchHoliday(_ sender: Any) {
        
        self.countryCode = textCountryCode.text!
        
        AF.request(urlString1 + countryCode + yearQuery + year).response { responseJSON in
//            debugPrint(responseJSON)
            
            
            if let json = try? JSON(data: responseJSON.data!) {
            
                
                for i in 0..<json["holidays"].count{
                    
                    self.holidayNames[i] = json["holidays"][i]["name"].description
                }
                
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    
    // table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = holidayNames[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        mainDelegate.holidayIndex = indexPath.row
        mainDelegate.countryCode = countryCode
        
        self.performSegue(withIdentifier: "segueHoliday", sender: nil)
    }

}
