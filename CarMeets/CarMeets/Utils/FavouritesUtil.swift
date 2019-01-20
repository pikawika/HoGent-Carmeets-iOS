//
//  FavouritesUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.

import Foundation
import UIKit

/**
 Een util om je te helpen werken met allerlei zaken omtrent een user zijn favorieten.
 */
class FavouritesUtil {
    /**
     Maakt een geformateerde string met aantal mensen die liked hebben adhv een Meeting object.
     
     - Parameter fromMeeting: De meeting waarvoor je de notatie wenst.
     
     - Returns: NSAttributedString in formaat -> icon + x mensen hebben dit geliked.
     */
    static func amountLikedNotation(fromMeeting meeting: Meeting) -> NSAttributedString {
        //Zie bronnen voor source.
        //Maak een attachment zijnde het icoon
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_liked_small")
        //Stel locatie icoon in
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Maak een string met icoon
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Zorg dat je een eigen string aan de string met icoon kan toevoegen
        let completeText = NSMutableAttributedString(string: "")
        //Voeg icoon toe aan aanpasbare string
        completeText.append(attachmentString)
        //Voeg tekst toe
        let textAfterIcon = NSMutableAttributedString(string: " " + String(meeting.listUsersLiked.count) + " mensen hebben dit geliked.")
        completeText.append(textAfterIcon)
        return completeText
    }
    
    /**
     Maakt een geformateerde string met aantal mensen die going hebben adhv een Meeting object.
     
     - Parameter fromMeeting: De meeting waarvoor je de notatie wenst.
     
     - Returns: NSAttributedString in formaat -> icon + x mensen gaan hier heen.
     */
    static func amountGoingNotation(fromMeeting meeting: Meeting) -> NSAttributedString {
        //Zie bronnen voor source.
        //Maak een attachment zijnde het icoon
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_going_small")
        //Stel locatie icoon in
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Maak een string met icoon
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Zorg dat je een eigen string aan de string met icoon kan toevoegen
        let completeText = NSMutableAttributedString(string: "")
        //Voeg icoon toe aan aanpasbare string
        completeText.append(attachmentString)
        //Voeg tekst toe
        let textAfterIcon = NSMutableAttributedString(string: " " + String(meeting.listUsersGoing.count) + " mensen gaan hier heen.")
        completeText.append(textAfterIcon)
        return completeText
    }
    
    /**
     Returnt of de huidige user al da niet naar een bepaalde meeting gaat.
     
     - Parameter toMeeting: De meeting waarvoor je de informatie wenst.
     
     - Returns: bool of user al dan niet gaat
     */
    static func isUserGoing(toMeeting meeting: Meeting) -> Bool {
        return meeting.listUsersGoing.contains(TokenUtil.getUserIdFromToken())
    }
    
    /**
     Returnt of de huidige user al da niet een bepaalde meeting geliked heeft.
     
     - Parameter meeting: De meeting waarvoor je de informatie wenst.
     
     - Returns: bool of user al dan niet geliked heeft
     */
    static func isUserLiking(meeting: Meeting) -> Bool {
        return meeting.listUsersLiked.contains(TokenUtil.getUserIdFromToken())
    }
    
    /**
     Returnt hoeveel meetings user liked en/of going heeft in de volgende 7 dagen van een gegeven lijst.
     
     - Parameter fromMeetingList: de lijst waarover je de gewenste informatie wilt.
     
     - Returns: Int met aantal meetings die aan creteria voldoen.
     */
    static func userFavouritesInNext7Days(fromMeetingList meetings: [Meeting]) -> Int {
        let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        return meetings.filter {
            ($0.listUsersGoing.contains(TokenUtil.getUserIdFromToken()) ||
                $0.listUsersLiked.contains(TokenUtil.getUserIdFromToken())) &&
                ($0.date < nextWeek ?? Date())
        }.count
    }
    
    
}


