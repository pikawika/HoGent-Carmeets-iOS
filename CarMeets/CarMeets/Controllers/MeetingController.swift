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
    
    //alle meetings in de toekomst van server halen
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
    
    //meetings van de server halen
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
