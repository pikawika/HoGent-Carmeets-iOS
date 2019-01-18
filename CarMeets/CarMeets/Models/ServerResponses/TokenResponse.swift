//
//  TokenResponse.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    var token: String?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case errorMessage = "message"
    }
}
