//
//  NetworkConstants.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let baseApiURL = URL(string: "https://carmeets-backend.herokuapp.com/API/")!
    static let baseApiMeetingsURL = URL(string: "https://carmeets-backend.herokuapp.com/API/meetings/")!
    static let baseApiUsersURL = URL(string: "https://carmeets-backend.herokuapp.com/API/users/")!
    static let baseImageURL = URL(string: "https://carmeets-backend.herokuapp.com/uploadImages/")!
}
