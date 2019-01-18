//
//  RegisterRequest.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    var username: String
    var password: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case email
    }
}
