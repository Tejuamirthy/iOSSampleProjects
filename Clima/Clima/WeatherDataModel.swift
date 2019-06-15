//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherDataModel {
    //Declare your model variables here
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //This method turns a condition code into the name of the weather condition image
    func updateWeatherIcon(condition: Int) -> String {
        var a: String = ""
        switch (condition) {
        case 0...300 :
            a = "tstorm1"
        case 301...500 :
            a = "light_rain"
        case 501...600 :
            a = "shower3"
        case 601...700 :
            a = "snow4"
        case 701...771 :
            a = "fog"
        case 772...799 :
            a = "tstorm3"
        case 800 :
            a = "sunny"
        case 801...804 :
            break
        case 900...903, 905...1000  :
            a = "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "dunno"
        }
        return a
    }
}
