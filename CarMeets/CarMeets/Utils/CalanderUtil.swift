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
     
     - Parameter withMeetingData: meeting waarvan de info in de kalander opgeslaan dient te worden
     */
    static func addEventToCalendar(withMeetingData meeting: Meeting, completion: @escaping ((Bool, String)) -> Void) {
        let eventStore = EKEventStore()
        
        //kijken of we toegang hebben tot kalender
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = meeting.title
                event.startDate = meeting.date
                event.endDate = meeting.date
                event.notes = meeting.description
                event.calendar = eventStore.defaultCalendarForNewEvents
                event.location = LocationUtil.fullAdressNotation(from: meeting.location())
                event.isAllDay = true
                do {
                    try eventStore.save(event, span: .thisEvent)
                    completion((true, meeting.title + " toegevoegd aan kalander!"))
                    return
                } catch {
                    completion((false, "kalander item opslaan mislukt."))
                    return
                }
            }
            completion((false, "Kalander item toevoegen mislukt."))
        })
    }
    
    /**
     Voegt een item toe aan de kalander van de gebruiker.
     
     - Parameter withMeetingData: meeting waarvan de info in de kalander opgeslaan dient te worden
     */
    static func isEventInCalander(withMeetingData meeting: Meeting, completion: @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()
        
        //kijken of we toegang hebben tot kalender
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                //is ingesteld op ganse dag dus date +1 enddate 
                let eventPredicate = eventStore.predicateForEvents(withStart: meeting.date, end: Calendar.current.date(byAdding: .day, value: 1, to: meeting.date) ?? meeting.date
                    , calendars: nil)
                
                let existingEventsOnMeetingDay = eventStore.events(matching: eventPredicate)
                
                let meetingAlreadyInCalander = existingEventsOnMeetingDay.contains(where: {event in
                    event.title == meeting.title
                        && event.notes == meeting.description
                        && event.location == LocationUtil.fullAdressNotation(from: meeting.location())})
                
                completion(meetingAlreadyInCalander)
            }
            completion(false)
        })
    }
}
