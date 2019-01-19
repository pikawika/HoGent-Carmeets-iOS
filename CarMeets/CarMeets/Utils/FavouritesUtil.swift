//
//  FavouritesUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class FavouritesUtil {
    /**
     Maakt een geformateerde string met aantal mensen die liked hebben adhv een Meeting object.
     
     - Parameter fromMeeting meeting: De meeting waarvoor je de notatie wenst.
     
     - Returns: NSAttributedString in formaat -> icon + x mensen liken dit.
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
     
     - Parameter fromMeeting meeting: De meeting waarvoor je de notatie wenst.
     
     - Returns: NSAttributedString in formaat -> icon + x mensen liken dit.
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
     
     - Parameter fromMeeting meeting: De meeting waarvoor je de informatie wenst.
     */
    static func isUserGoing(toMeeting meeting: Meeting) -> Bool {
        return meeting.listUsersGoing.contains(TokenUtil.getUserIdFromToken())
    }
    
    /**
     Returnt of de huidige user al da niet een bepaalde meeting geliked heeft.
     
     - Parameter fromMeeting meeting: De meeting waarvoor je de informatie wenst.
     */
    static func isUserLiking(meeting: Meeting) -> Bool {
        return meeting.listUsersLiked.contains(TokenUtil.getUserIdFromToken())
    }
    
    
}


