//
//  MeetingController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

//nodig voor img op te halen van url
import UIKit

/**
 Controller verantwoordelijk voor het uitvoeren van meeting gerelateerde functies
 */
class MeetingController {
    
    /**
     Controller verantwoordelijk voor het uitvoeren van meeting gerelateerde functies
     */
    static let shared = MeetingController()
    
    var meetings = [Meeting]() {
        didSet {
            NotificationCenter.default.post(name: .meetingsChanged, object: nil)
        }
    }
    
    /**
     Haalt alle actieve meetings op van de server en waarschuwt notifactionCenter.
     */
    func fetchMeetings() {
        let allMeetingsURL = NetworkConstants.baseApiMeetingsURL.appendingPathComponent("alleMeetings")
        let task = URLSession.shared.dataTask(with: allMeetingsURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //custom date format nodig voor het verstaan van ExpressJS date response
            jsonDecoder.dateDecodingStrategy = .formatted(.dateFromCarMeetsServer)
            if let data = data
            {
                let meetings = try! jsonDecoder.decode([Meeting].self, from: data)
                self.meetings = meetings
            }
        }
        task.resume()
    }
    
    
    /**
     Toggled like op gegeven meeting en haalt meetings opnieuw op.
     
     - Parameter withToggleLikedRequest: een request met de id van de meeting waarvan je like wilt togglen!
     */
    func toggleLikedForMeeting(withToggleLikedRequest toggleLikedRequest: ToggleLikeRequest) {
        let toggleLikedURL = NetworkConstants.baseApiMeetingsURL.appendingPathComponent("toggleLiked")
        var request = URLRequest(url: toggleLikedURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(toggleLikedRequest)
        request.httpBody = jsonData
        request.setValue("Bearer " + KeyChainUtil.getTokenFromKeychain(), forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if (httpResponse.statusCode == 200) {
                    
                    self.fetchMeetings()
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    /**
     Toggled going op gegeven meeting en haalt meetings opnieuw op.
     
     - Parameter withToggleGoingRequest: een request met de id van de meeting waarvan je going wilt togglen!
     
     */
    func toggleGoingForMeeting(withToggleGoingRequest toggleGoingRequest: ToggleGoingRequest) {
        let toggleLikedURL = NetworkConstants.baseApiMeetingsURL.appendingPathComponent("toggleGoing")
        var request = URLRequest(url: toggleLikedURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(toggleGoingRequest)
        request.httpBody = jsonData
        request.setValue("Bearer " + KeyChainUtil.getTokenFromKeychain(), forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if (httpResponse.statusCode == 200) {
                    
                    self.fetchMeetings()
                    
                }
            }
        }
        task.resume()
    }
    
    /**
     Haalt een image op van de server met een opgegeven naam.
     
     - Parameter imageName: de naam van de image zoals deze op de server is opgeslaan.
     
     - Returns: Een UIImage objecten als completion Void.
     */
    func fetchMeetingImage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let imageURL = NetworkConstants.baseImageURL.appendingPathComponent(imageName)
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
