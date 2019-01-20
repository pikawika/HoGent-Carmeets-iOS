//
//  ToggleLikeRequest.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Struct voor het helpen encoden van een server request die meetingId bevat voor het togglen van like.
 */
struct ToggleLikeRequest: Codable {
    var meetingId : String
    
    enum CodingKeys: String, CodingKey {
        case meetingId = "idMeeting"
    }
}
