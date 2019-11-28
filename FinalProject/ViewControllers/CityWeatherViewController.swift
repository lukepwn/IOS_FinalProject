//
//  CityWeatherViewController.swift
//  FinalProject
//
//  Created by Kevin Kim on 2019-11-27.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CityWeatherViewController: UIViewController {

    let APPID: String = "&appid=03c79c2a3f1c41eff2c3f7d8a726ce4e"
    let urlString: String = "https://api.openweathermap.org/data/2.5/weather?q="
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        AF.request(urlString + mainDelegate.cityName + APPID).response { responseJSON in
            //                        debugPrint(responseJSON)
            
            if let json = try? JSON(data: responseJSON.data!) {
                
                self.cityName.text = mainDelegate.cityName
                self.temperature.text = json["main"]["temp"].description
                self.high.text = json["main"]["temp_max"].description
                self.low.text = json["main"]["temp_min"].description

                let urlString1: String = "https://openweathermap.org/img/w/"
                let urlString3: String = ".png"
                let urlString2: String = json["weather"][0]["icon"].description

                if let urlString = try? (urlString1+urlString2+urlString3).asURL() {
                    do{
                        let data = try Data(contentsOf: urlString)
                        self.weatherIcon.image = UIImage(data: data)
                    }catch{

                    }
                }
                
                self.pressure.text = json["main"]["pressure"].description
                self.humidity.text = json["main"]["humidity"].description
                
            }
        }
    }
}
