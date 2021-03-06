//
//  WeatherApiManager.swift
//  WeatherApp
//
//  Created by Сергей on 05/03/2018.
//  Copyright © 2018 Sergei. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class WeatherAPIManager  {
    
    let apiKey = "9a08d9c78288bc77c1974e6a9d70d83e"
    let baseURl = "https://api.openweathermap.org/data/2.5/forecast?"
    static let sharedInstance = WeatherAPIManager()
    
    func getURL(latitude: Double, longitude: Double, metric:String = "metric") -> String {
        let currentURL = "\(baseURl)appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)&units=\(metric)"
        return currentURL
    }
    
    
    
    
    
    
    func requestGETURL(latitude: Double, longitude: Double, metric:String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        let url = getURL(latitude: latitude, longitude: longitude, metric: metric)
        Alamofire.request(url).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func parserJSON(json: JSON) -> [Weather] {
        var data:[Weather] = []
        for i in 0..<json["list"].count {
            data.append(Weather(dateTime: json["list"][i]["dt_txt"].stringValue, temperature: json["list"][i]["main"]["temp"].stringValue))
        }
        return data
    }
    
    
    
    
}



