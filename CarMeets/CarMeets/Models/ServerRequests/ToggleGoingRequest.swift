//
//  ToggleGoingRequest.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

struct ToggleGoingRequest: Codable {
    var meetingId : String
    
    enum CodingKeys: String, CodingKey {
        case meetingId = "idMeeting"
    }
}
