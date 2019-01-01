//
//  MeetingController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingController {
    
    static let shared = MeetingController()
    
    let baseApiURL = URL(string: "https://carmeets-backend.herokuapp.com/API/")!
    let baseImageURL = URL(string: "https://carmeets-backend.herokuapp.com/uploadImages/")!
    
    /**
     Haalt alle actieve meetings op van de server.
     
     - Returns: Array van Meeting objecten als completion Void.
     */
    func fetchMeetings(completion: @escaping ([Meeting]?) -> Void) {
        let allMeetingsURL = baseApiURL.appendingPathComponent("meetings/alleMeetings")
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
     Haalt een image op van de server met een opgegeven naam.
     
     - Parameter imageName: de naam van de image zoals deze op de server is opgeslaan.
     
     - Returns: Een UIImage objecten als completion Void.
     */
    func fetchMeetingImage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let imageURL = baseImageURL.appendingPathComponent(imageName)
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
