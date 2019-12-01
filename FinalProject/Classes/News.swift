//
//  News.swift
//  FinalProject
//
//  Created by Trevor Rubie on 2019-12-01.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import SwiftyJSON

class News: NSObject {

    var title : String?
    var website : String?
    
    init(json: JSON){
        self.title = json["title"].stringValue
        self.website = json["url"].stringValue
    }
}
