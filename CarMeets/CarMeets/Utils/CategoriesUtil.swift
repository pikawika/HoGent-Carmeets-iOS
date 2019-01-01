//
//  CategoriesUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 01/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class CategoriesUtil {
    /**
     Maakt een geformateerde string adhv een lijst van string object. bv: french | audio | lowered
     
     - Parameter from categories: De lijst van strings (categorien) waarvan je de notatie wenst.
     
     - Returns: String in formaat -> icon + category1 | category2
     */
    static func listNotation(from categories: [String]) -> NSAttributedString {
        //Zie bronnen voor source.
        //Maak een attachment zijnde het icoon
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_cars_small")
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
        let textAfterIcon = NSMutableAttributedString(string: " Categoriën: " + categories.joined(separator:" | "))
        completeText.append(textAfterIcon)
        return completeText
    }
}
