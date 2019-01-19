//
//  NotificationExtensions.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var meetingsChanged: Notification.Name {
        return .init(rawValue: "[Meeting]")
    }
}
