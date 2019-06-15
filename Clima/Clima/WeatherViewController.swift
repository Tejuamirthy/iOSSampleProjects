//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "c53a12ed7ac09cd25e05f14b2dc50ebf"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
        //MARK: - CreateViewProgramatically
        //uncomment the below commented lines
        //        let a =  UIView()
        //        self.view.addSubview(a)
        //        a.translatesAutoresizingMaskIntoConstraints = false
        //        a.backgroundColor = UIColor.red
        //
        //        a.heightAnchor.constraint(equalToConstant: 130).isActive = true
        //        a.widthAnchor.constraint(equalToConstant: 130).isActive = true
        //        a.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
        //        a.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
        //

        
        
    }
    


//        struct coordinates {
//            let lon: Double
//            let lat: Double
//        }
//        let coord: coordinates
//        base
//    "coord":{"lon":37.62,"lat":55.76},
//    "weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],
//    "base":"stations",
//    "main":{"temp":286.28,"pressure":1028,"humidity":46,"temp_min":285.15,"temp_max":287.15},
//    "visibility":10000,
//    "wind":{"speed":6,"deg":80},
//    "clouds":{"all":0},
//    "dt":1560408402,
//    "sys":{"type":1,"id":9027,"message":0.0059,"country":"RU","sunrise":1560386709,"sunset":1560449638},
//    "timezone":10800,
//    "id":524925,
//    "name":"Moskovskaya Oblast’",
//    "cod":200
//    
//    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url : String, parameters : [String : String]){
        print(parameters)
        
        
        let request = Alamofire.request("http://api.openweathermap.org/data/2.5/weather", method: .get, parameters: parameters)
        print(request)
        request.responseJSON { (response) in
            if response.result.isSuccess {
                if response.result.value != nil{
                    if let someValue  = response.result.value{
                        let weatherJSON : JSON =  JSON(someValue)
                        print(response)
                        self.updateWeatherData(json : weatherJSON)
                    }
                    
                }
            }
            else{
                print("Error response isn't success")
                print(response)
            }
        }
        
    }

    
    func getWeatherUsingUrl(url : String, parameters : [String : String]){
        
        guard let lat = parameters["lat"],let lon = parameters["lon"] else { return }
        let finalUrlString =  "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APP_ID)"
        
        guard let finalUrl: URL = URL(string: finalUrlString) else{ return }
        
        
        URLSession.shared.dataTask(with: finalUrl) {
            (data, response, error) in
            
            guard let data = data else {
                print("Error inside guard let")
                return }
            do{
                print(data)
                let decoder = JSONDecoder()
                let weatherStruct = try? decoder.decode(WeatherStruct.self, from: data)
                guard let weather = weatherStruct else{ return }
                DispatchQueue.main.async {
                    self.updateWeatherDataWithModel(weatherStruct: weather)
                }

            }
            
        }.resume()
        
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   

    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(tempResult - 273.15) //temp was coming in kelvins
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        }
        else{
            cityLabel.text = "Weather Unavailable"
        }
    }

    func updateWeatherDataWithModel(weatherStruct: WeatherStruct) {
        
        guard let cityName = weatherStruct.name,let id = weatherStruct.weather?[0].id,let tempResult = weatherStruct.main?.temp else {
            cityLabel.text = "Weather Unavailable"
            return
        }
//        DispatchQueue.main.async {
//
//        }
            weatherDataModel.temperature = Int(tempResult - 273.15) //temp was coming in kelvins
            weatherDataModel.city = cityName
            weatherDataModel.condition = id
            weatherDataModel.weatherIconName =  weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
    
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
        
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            print("longitude : \(longitude), latitude : \(latitude)")
            
            
            let params : [ String : String ] = [ "lon" : longitude , "lat" : latitude, "appid" : APP_ID ]
            
            //getWeatherData(url: APP_ID, parameters: params)
            getWeatherUsingUrl(url: APP_ID, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavialable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String) {
        let params = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
            
        }
        
    }
    
    
    
    
}


