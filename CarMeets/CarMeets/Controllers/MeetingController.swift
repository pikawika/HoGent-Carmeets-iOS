//
//  MeetingController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

//nodig voor img op te halen van url
import UIKit

class MeetingController {
    
    static let shared = MeetingController()
    
    private let notificationCenter: NotificationCenter
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    /**
     Haalt alle actieve meetings op van de server en waarschuwt notifactionCenter.
     */
    func fetchMeetings() {
        fetchMeetingsFromServer { (meetings) in
            if let meetings = meetings {
                self.notificationCenter.post(name: .meetingsChanged, object: meetings)
            }
        }
    }
    
    
    /**
     Toggled like op gegeven functie en returnt deze functie nadat like bewerking voltooid is.
     
     - Parameter meetingId: de id van de meeting dat je wenst te togglen.
     
     - Returns: De meeting waarvan like getoggled is.
     */
    func toggleLiked(withToggleLikedRequest toggleLikedRequest: ToggleLikeRequest ,completion: @escaping (Meeting?) -> Void) {
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
                    
                    self.fetchMeetingsFromServer { (meetings) in
                        if let meetings = meetings {
                            self.notificationCenter.post(name: .meetingsChanged, object: meetings)
                            completion(ListFilterUtil.getMeetingWithID(fromMeetingList: meetings, withMeetingId: toggleLikedRequest.meetingId))
                        } else {
                            //meetings niet returnt
                            completion(nil)
                        }
                    }
                    
                } else {
                    //code niet ok (!=200)
                    completion(nil)
                }
                
            } else {
                // HTTPURLResponse niet correct kunnen bepalen
                completion(nil)
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
    
    
    /**
     Haalt alle actieve meetings op van de server.
     
     - Returns: Array van Meeting objecten als completion Void.
     */
    private func fetchMeetingsFromServer(completion: @escaping ([Meeting]?) -> Void) {
        let allMeetingsURL = NetworkConstants.baseApiMeetingsURL.appendingPathComponent("alleMeetings")
        let task = URLSession.shared.dataTask(with: allMeetingsURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //custom date format nodig voor het verstaan van ExpressJS date response
            jsonDecoder.dateDecodingStrategy = .formatted(.dateFromCarMeetsServer)
            if let data = data
            {
                let meetings = try! jsonDecoder.decode([Meeting].self, from: data)
                completion(meetings)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
