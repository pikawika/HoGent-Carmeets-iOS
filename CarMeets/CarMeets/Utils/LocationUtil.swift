//
//  LocationUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 01/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class LocationUtil {
    /**
     Maakt een geformateerde string adhv een location object. bv: 9260, Schellebelle
     
     - Parameter from location: De locatie waarvan je de city notation wenst.
     
     - Returns: NSAttributedString in formaat -> icon + postal, city.
     */
    static func fullCityNotationWithIcon(from location: Location) -> NSAttributedString {
        //Zie bronnen voor source.
        //Maak een attachment zijnde het icoon
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_location_small")
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
        let textAfterIcon = NSMutableAttributedString(string: " " + location.postalCode + ", " + location.city)
        completeText.append(textAfterIcon)
        return completeText
    }
    
    /**
     Maakt een geformateerde string adhv een location object. bv: Dendermondsesteenweg 92, 9260 Schellebelle
     
     - Parameter from location: De locatie waarvan je de city notation wenst.
     
     - Returns: NSAttributedString in formaat -> icon + street housenr, postal city.
     */
    static func fullAdressNotationWithIcon(from location: Location) -> NSAttributedString {
        //Zie bronnen voor source.
        //Maak een attachment zijnde het icoon
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_location_small")
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
        let textAfterIcon = NSMutableAttributedString(string: " " + location.streetName + " " + location.houseNumber + ", " + location.postalCode + " " + location.city)
        completeText.append(textAfterIcon)
        return completeText
    }
    
    /**
     Maakt een geformateerde string adhv een location object. bv: Dendermondsesteenweg 92, 9260 Schellebelle
     
     - Parameter from location: De locatie waarvan je de city notation wenst.
     
     - Returns: string in formaat -> street housenr, postal city.
     */
    static func fullAdressNotation(from location: Location) -> String {
        return location.streetName + " " + location.houseNumber + ", " + location.postalCode + " " + location.city
    }
}
