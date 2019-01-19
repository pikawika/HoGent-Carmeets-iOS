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
    
    /**
     Haalt alle actieve meetings op van de server.
     
     - Returns: Array van Meeting objecten als completion Void.
     */
    func fetchMeetings(completion: @escaping ([Meeting]?) -> Void) {
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
    
    /**
     Haalt alle actieve meetings op van de server en filtert diegene uit dat de user geliked of going heeft.
     
     - Returns: Array van Meeting objecten als completion Void.
     */
    func fetchMeetingsFromUser(completion: @escaping ([Meeting]?) -> Void) {
        let allMeetingsURL = NetworkConstants.baseApiMeetingsURL.appendingPathComponent("alleMeetings")
        let task = URLSession.shared.dataTask(with: allMeetingsURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //custom date format nodig voor het verstaan van ExpressJS date response
            jsonDecoder.dateDecodingStrategy = .formatted(.dateFromCarMeetsServer)
            if let data = data
            {
                var meetings = try! jsonDecoder.decode([Meeting].self, from: data)
                
                //indien gebruiker zijn id in liked of going behoord het tot zijn favorieten
                meetings = meetings.filter {
                    $0.listUsersGoing.contains(TokenUtil.getUserIdFromToken()) ||
                    $0.listUsersLiked.contains(TokenUtil.getUserIdFromToken())
                }
                
                completion(meetings)
            } else {
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
    
}
