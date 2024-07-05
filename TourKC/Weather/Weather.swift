//
//  Weather.swift
//  TourKC
//
//  Created by Nathan Bronson on 6/4/22.
//

import Foundation

class WeatherService {
    static let shared = WeatherService() //create static version to prevent unnecessary reexecution
    
    let STEM: String = "https://api.openweathermap.org/data/2.5/weather?" //store base of URL
    let API_KEY: String = WEATHER_API_KEY //reference config for key (no hard code for security)
    var items: WResult? = nil //store optional result
    
    let session = URLSession(configuration: .default) //create session for API call
    
    func buildURL() -> String { //combine stem with api key and location and unit info
        return STEM + "q=Kansas%20City&units=imperial&appid=" + API_KEY
    }
    
    func getWeather(finished: @escaping (_ items: WResult) -> Void) -> Void { //get weather and execute closure with it as an argument
        print(buildURL()) //logging URL for debugging
        let sem = DispatchSemaphore.init(value: 0) //have function wait to return until execution is done
        guard let url = URL(string: buildURL()) else { //reach out to URL
            print("error") //log error
            return //end function
        }
        let task = session.dataTask(with: url) { (data, response, error) in //get result of call
            defer { sem.signal() } //give signal to return
            if let error = error { //detect error
                print("itemsERROR")
                print(error.localizedDescription) //debugging
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else { //detect invalid response or data
                print("itemsInvalid data or response")
                return
            }
            
            do {
                if response.statusCode == 200 { //check that call was valid
                    let items = try JSONDecoder().decode(WResult.self, from: data) //decode response
                    finished(items) //call closure
                    return //end execution
                } else {
                    print("itemsResponse wasn't 200. It was: " + "\n\(response.statusCode)") //log error
                }
            } catch { //handle and log error
                print("itemsCATCH")
                print(error)
                print(error.localizedDescription)
            }
        }
        task.resume() //run task
        sem.wait() //wait for task to complete
        return
    }
    
}
