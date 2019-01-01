//
//  CalanderUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 01/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class CalanderUtil {
    /**
     Voegt een item toe aan de kalander van de gebruiker.
     
     - Parameter title: de titel voor het kalander item.
     - Parameter description: de beschrijving voor het kalander item.
     - Parameter location: de locatie voor het kalander item.
     - Parameter startDate: de startdatum voor het kalander item.
     - Parameter endDate: de einddatum voor het kalander item.
     - Parameter controller: de controller waarin de succes/fail toast zal moeten weergeven worden.
     */
    static func addEventToCalendar(title: String, description: String, location: String, startDate: Date, endDate: Date, controller: UIViewController, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        //kijken of we toegang hebben tot kalender
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                event.location = location
                event.isAllDay = true
                do {
                    try eventStore.save(event, span: .thisEvent)
                    MessageUtil.showToast(message: "Meeting aan kalander toegevoegd!", durationInSeconds: 1, controller: controller)
                } catch let e as NSError {
                    completion?(false, e)
                    MessageUtil.showToast(message: "Toevoegen mislukt.", durationInSeconds: 1, controller: controller)
                    return
                }
                completion?(true, nil)
            } else {
                MessageUtil.showToast(message: "Toevoegen mislukt.", durationInSeconds: 1, controller: controller)
                completion?(false, error as NSError?)
            }
        })
    }
}
