//
//  TokenResponse.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Struct voor het helpen decoden van een server response die token of errorMessage bevat.
 */
struct TokenResponse: Codable {
    var token: String?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case errorMessage = "message"
    }
}
