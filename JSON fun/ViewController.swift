//
//  ViewController.swift
//  JSON fun
//
//  Created by Sebastian Hette on 27.10.2016.
//  Copyright © 2016 MAGNUMIUM. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        parseCompetitonsJson()
        
    }
    func parseCompetitonsJson() {
        let url = URL(string: "http://data.judobase.org/api/get_json?access_token=&params%5Baction%5D=competition.get_list&params%5B__ust%5D=&params%5Byear%5D=&params%5Bmonth%5D=&params%5Brank_group%5D=&params%5Bsort%5D=-1")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        for dictionary in myJson as! [[String:AnyObject]] {
                            
                            var competitions = [Competition]()
                            let name = dictionary["name"] as? String
                            let rank_name = dictionary["rank_name"] as? String
                            let city = dictionary["city"] as? String
                            let country_short = dictionary["country_short"] as? String
                            let competition_code = dictionary["competition_code"] as? String
                            let id_country = dictionary["id_country"] as? String
                            let id_competiton = dictionary["id_competition"] as? String
                            let date_from = dictionary["date_from"] as? String
                            let date_to = dictionary["date_to"] as? String
                            let has_results = dictionary["has_results"] as? String
                            let comp_year = dictionary["comp_year"] as? String
                            let country = dictionary["country"] as? String
                            
                            let competiton = Competition(name: name, rank_name: rank_name, city: city, country_short: country_short, competiton_code: competition_code, id_country: id_country, id_competiton: id_competiton, date_from: date_from, date_to: date_to, has_results: has_results, comp_year: comp_year, country: country)
                            
                            competitions.append(competiton)
                            let url = URL(string: "http://data.judobase.org/api/get_json?access_token=&params%5Baction%5D=competitor.info&params%5B__ust%5D=&params%5Bid_person%5D=\(id_competiton!)")
                            print(url!)
                            
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        task.resume()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

