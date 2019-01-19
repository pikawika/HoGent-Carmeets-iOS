//
//  ListFilterUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

class ListFilterUtil {
    /**
     Haalt de token op uit de KeyChain en haalt de gebruikersnaam er uit.
     */
    static func getUserFavourites(fromMeetingList meetings: [Meeting]) -> [Meeting] {
        return meetings.filter {
            $0.listUsersGoing.contains(TokenUtil.getUserIdFromToken()) ||
                $0.listUsersLiked.contains(TokenUtil.getUserIdFromToken())
        }
    }
    
    /**
     Returnt de meeting met de meegegeven id of nil
     */
    static func getMeetingWithID(fromMeetingList meetings: [Meeting], withMeetingId meetingId: String) -> Meeting? {
        return meetings.first {
            $0.meetingId == meetingId
        }
    }
    
    /**
     Returnt de meeting met de meegegeven id of nil
     */
    static func getNextMeeting(fromMeetingList meetings: [Meeting], withCurrentMeeting meeting: Meeting) -> Meeting? {
        
        if let currentIndex = meetings.firstIndex(where: { $0.meetingId == meeting.meetingId }) {
            if currentIndex < (meetings.count - 1) {
                //indien er volgende is return die anders return eerste
                return meetings[currentIndex + 1]
            }
        }
        
        return meetings[0]
    }
    
    /**
     Returnt de meeting met de meegegeven id of nil
     */
    static func getPreviousMeeting(fromMeetingList meetings: [Meeting], withCurrentMeeting meeting: Meeting) -> Meeting? {
        
        if let currentIndex = meetings.firstIndex(where: { $0.meetingId == meeting.meetingId }) {
            if currentIndex != 0 {
                //indien er volgende is return die anders return eerste
                return meetings[currentIndex - 1]
            }
        }
        
        return meetings[meetings.count - 1]
    }
    
}
