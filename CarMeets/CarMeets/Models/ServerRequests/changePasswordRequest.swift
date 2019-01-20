//
//  changePasswordRequest.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 20/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

struct ChangePasswordRequest: Codable {
    var newPassword : String
    
    enum CodingKeys: String, CodingKey {
        case newPassword
    }
}
