//
//  ListFilterUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Een util om je te helpen met het filteren van lijsten.
 */
class ListFilterUtil {
    /**
     Haalt de userId op uit de token en returnt de meetings dat de aangemelde gebruiker liked of going heeft in de meegegeven lijst.
     
     - Parameter fromMeetingList: Lijst waarop je wilt filteren.
     
     - Returns: Lijst van meetings waarvoor gebruiker liked of going heeft aangegeven.
     */
    static func getUserFavourites(fromMeetingList meetings: [Meeting]) -> [Meeting] {
        return meetings.filter {
            $0.listUsersGoing.contains(TokenUtil.getUserIdFromToken()) ||
                $0.listUsersLiked.contains(TokenUtil.getUserIdFromToken())
        }
    }
    
    /**
     Haalt de userId op uit de token en returnt de meetings dat de aangemelde gebruiker liked of going heeft in de meegegeven lijst.
     
     - Parameter fromMeetingList: Lijst waarop je wilt filteren.
     
     - Parameter withMeetingId: Id van de meeting die je wenst.
     
     - Returns: Meeting met meegegven meetingId of nil.
     */
    static func getMeetingWithID(fromMeetingList meetings: [Meeting], withMeetingId meetingId: String) -> Meeting? {
        return meetings.first {
            $0.meetingId == meetingId
        }
    }
    
    /**
     Geeft de volgende meeting in de lijst, start terug bij index 0 indien einde bereikt.
     
     - Parameter fromMeetingList: Lijst waarop je wilt filteren.
     
     - Parameter withCurrentMeeting: index van de huidige meeting.
     
     - Returns: volgende meeting in de lijst.
     */
    static func getNextMeeting(fromMeetingList meetings: [Meeting], withCurrentMeeting meeting: Meeting) -> Meeting? {
        
        if let currentIndex = meetings.firstIndex(where: { $0.meetingId == meeting.meetingId }) {
            if currentIndex < (meetings.count - 1) {
                //indien er volgende is return die anders return eerste
                return meetings[currentIndex + 1]
            }
        }
        
        //zeker zijn dat lijst niet leeg is
        if meetings.count > 0  {
            return meetings[0]
        }
        
        return nil
    }
    
    /**
     Geeft de vorige meeting in de lijst, start terug bij het einde indien begin bereikt.
     
     - Parameter fromMeetingList: Lijst waarop je wilt filteren.
     
     - Parameter withCurrentMeeting: index van de huidige meeting.
     
     - Returns: vorige meeting in de lijst.
     */
    static func getPreviousMeeting(fromMeetingList meetings: [Meeting], withCurrentMeeting meeting: Meeting) -> Meeting? {
        
        if let currentIndex = meetings.firstIndex(where: { $0.meetingId == meeting.meetingId }) {
            if currentIndex != 0 {
                //indien er volgende is return die anders return eerste
                return meetings[currentIndex - 1]
            }
        }
        
        //zeker zijn dat lijst niet leeg is
        if meetings.count > 0  {
            return meetings[meetings.count - 1]
        }
        
        return nil
    }
    
}
