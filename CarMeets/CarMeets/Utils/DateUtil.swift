//
//  DateUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 01/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Een util om je te helpen werken met allerlei zaken omtrent een datum.
 */
class DateUtil {
    /**
     Maakt een geformateerde string adhv een date object.
     
     - Parameter fromDate: De datum vanwaar je de string notatie wenst.
     
     - Returns: String in formaat dd/MM/yyyy.
     */
    static func shortDateNotation(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    /**
     Maakt een geformateerde string adhv een date object.
     
     - Parameter fromDate: De datum vanwaar je de string notatie wenst.
     
     - Returns: String met dag van de maand (numeriek).
     */
    static func dayNotation(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    /**
     Maakt een geformateerde string adhv een date object.
     
     - Parameter from date: De datum vanwaar je de string notatie wenst.
     
     - Returns: String met de maand zijn eerste drie letters.
     */
    static func shortMonthDateNotation(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return String(dateFormatter.string(from: date).prefix(3))
    }
    
}


/**
 Een dateformatter voor het omzetten van een server datum naar een door swift verstaanbaar date object
 */
extension DateFormatter {
    static let dateFromCarMeetsServer: DateFormatter = {
        let formatter = DateFormatter()
        //vb datum van server: 2019-01-29T22:00:00.000Z
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }()
}
