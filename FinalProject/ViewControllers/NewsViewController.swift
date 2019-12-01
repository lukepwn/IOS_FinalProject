//
//  NewsViewController.swift
//  FinalProject
//
//  Created by Trevor Rubie on 2019-11-29.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBAction func unwindToNewsViewController(segue: UIStoryboardSegue) {
    }
    var news = [News]()
    let newsApi = "https://api.hnpwa.com/v0/news/1.json"
    @IBOutlet weak var newsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : SiteCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = news[rowNum].title
        tableCell.secondaryLabel.text = news[rowNum].website
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        mainDelegate.headline = news[indexPath.row].title!
        mainDelegate.url = news[indexPath.row].website!
        
        performSegue(withIdentifier: "WebsiteSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AF.request(newsApi).responseJSON{
        response in
        
            if let data = try? JSON(data: response.data!){
            
            let newsJSON = data.arrayValue
            
            for marvelJSON in newsJSON {
                print(marvelJSON)
                let h = News(json: JSON(marvelJSON))
                self.news.append(h)
                self.newsTable.reloadData()
            }
            }
                
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
