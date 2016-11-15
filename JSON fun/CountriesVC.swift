//
//  countries.swift
//  JSON fun
//
//  Created by Boris Rudas on 15/11/2016.
//  Copyright © 2016 MAGNUMIUM. All rights reserved.
//

import UIKit

class CountriesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

            parseCountriesJson()
    }

    func parseCountriesJson() {
        let url = URL(string: "http://data.judobase.org/api/get_json?access_token=&params%5Baction%5D=country.get_list&params%5B__ust%5D=")
        
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
                            
                            let name = dictionary["name"] as! String
                            let ioc = dictionary["ioc"] as! String
                            let id_country = dictionary["id_country"] as! String
                            

                            let id_countryInt = Int(id_country)
                            
                            let country = Country(id_country: id_countryInt!, ioc: ioc, name: name)
                            
                            var countries = [Country]()
                            countries.append(country)
                            print(countries)
//
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
