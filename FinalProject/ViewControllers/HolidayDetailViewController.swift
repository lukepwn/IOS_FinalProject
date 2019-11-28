//
//  HolidayDetailViewController.swift
//  FinalProject
//
//  Created by Xcode User on 2019-11-27.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HolidayDetailViewController: UIViewController {

    
    
    @IBOutlet weak var holidayName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var `public`: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var weekday: UILabel!
    
    
    let urlString: String = "https://holidayapi.com/v1/holidays?pretty&key="
    let APIKey: String = "44e17311-7056-47c6-9c7c-bc86163ae2c4"
    let countryQuery: String = "&country="
    let country: String = ""
    let yearQuery: String = "&year="
    let year: String = "2018"
    var urlString1: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainDelegate = UIApplication.shared.delegate as! AppDelegate

        
        self.urlString1 = urlString + APIKey + countryQuery + mainDelegate.countryCode + yearQuery + year
        
        AF.request(urlString1).response { responseJSON in
                        debugPrint(responseJSON)
            
            
            if let json = try? JSON(data: responseJSON.data!) {
                
                self.holidayName.text = json["holidays"][mainDelegate.holidayIndex]["name"].description
                self.date.text = json["holidays"][mainDelegate.holidayIndex]["date"].description
                self.public.text = json["holidays"][mainDelegate.holidayIndex]["public"].description
                self.countryName.text = json["holidays"][mainDelegate.holidayIndex]["country"].description
                self.weekday.text = json["holidays"][mainDelegate.holidayIndex]["weekday"]["date"]["name"].description
                
            }
        }
        
        
    }
}
