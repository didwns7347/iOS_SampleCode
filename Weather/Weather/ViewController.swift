//
//  ViewController.swift
//  Weather
//
//  Created by yangjs on 2022/03/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var citiyNameTextField: UITextField!
    @IBOutlet weak var cityNaneLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempaLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var weatherInfoStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapedFetchWeatherBtn(_ sender: Any) {
        if let cityName = self.citiyNameTextField.text{
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
            //self.weatherInfoStackView.isHidden = false
        }
    }
    
    func configureView(weatherInformation: WeatherInfo){
        self.citiyNameTextField.text = weatherInformation.name
        if let weather = weatherInformation.weather.first{
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempaLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        self.minTempLabel.text = "최저:\(Int(weatherInformation.temp.minTemp - 273.15))°C"
        self.maxTempLabel.text = "최고:\(Int(weatherInformation.temp.maxTemp - 273.15))°C"
    }
    
    func showAlert(message: String) {
      let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
    
    func getCurrentWeather(cityName:String){
        //https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=3b80de7713592ced4ecd2528ba45a8b0
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=3b80de7713592ced4ecd2528ba45a8b0") else{return}
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){[weak self]  data,response,error in
            let successRange = (200..<300)
            
            guard let data = data, error==nil else{return}
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode){
                guard let weatherInfo = try? decoder.decode(WeatherInfo.self, from: data) else{return}
                DispatchQueue.main.async {
                    self?.weatherInfoStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInfo)
                }
            }else {
                guard let errorMesaage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMesaage.message)
                }
            }
            
        }.resume()
    }
}

