//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Renan de Matos on 24/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTemp()
        
    }
    
    func getTemp() {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Porto%20Alegre,br&units=metric&appid=aeefba332b49db396d425480b21571b2")
        
        if let url = url {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let data = data, error == nil {
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        
                        let weather = try decoder.decode(Weather.self, from: data)
                        
                        self.weather = weather
                        
                        print(weather)
                
                        DispatchQueue.main.async {
                            
                            self.tempLabel.text = "\(weather.main.temp)"
                            self.cityLabel.text = "\(weather.name)"
                            
                        }
                        
                    } catch let error {
                        
                        print(error.localizedDescription)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    @IBAction func searchActionButton(_ sender: Any) {
        
        
    }
    
}



