//
//  MeetingController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingController {
    
    let baseApiURL = URL(string: "https://carmeets-backend.herokuapp.com/API/")!
    
    func fetchMeetings(completion: @escaping ([Meeting]?) -> Void) {
        let allMeetingsURL = baseApiURL.appendingPathComponent("meetings/alleMeetings")
        let task = URLSession.shared.dataTask(with: allMeetingsURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let meetings = try? jsonDecoder.decode(Meetings.self, from: data) {
                completion(meetings.meetings)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
