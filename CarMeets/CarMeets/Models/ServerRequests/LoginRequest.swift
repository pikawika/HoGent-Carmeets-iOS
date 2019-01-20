//
//  LoginRequest.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Struct voor het helpen encoden van een server request die login informatie bevat.
 */
struct LoginRequest: Codable {
    var username: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
