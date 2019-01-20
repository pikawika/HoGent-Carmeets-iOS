//
//  CarMeetsTests.swift
//  CarMeetsTests
//
//  Created by Lennert Bontinck on 06/11/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import XCTest
@testable import CarMeets

class CarMeetsTests: XCTestCase {
    var meetingUnderTest: Meeting!
    var dateUnderTest: Date!

    override func setUp() {
        meetingUnderTest = Meeting.init(meetingId: "1", imageName: "1", title: "title1", subtitle: "subtitle1", description: "description1", date: Date(), city: "Schellebelle", postalCode: "9260", streetName: "Dendermondsesteeweng", houseNumber: "92", categories: ["Cat1", "Cat2"], listUsersGoing: ["1","2","3"], listUsersLiked: ["3","4","5"], website: "https://lennertbontinck.com/")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateUnderTest = formatter.date(from: "1998/12/23")
        
        
    }

    override func tearDown() {
        meetingUnderTest = nil
    }

    func testLocation_isGeneratableFromMeetingObject() {
        //when
        let locationObjectFromMeeting = meetingUnderTest.location()
    
        //then
        XCTAssertEqual(locationObjectFromMeeting.city, meetingUnderTest.city, "Location object generated from meeting incorrect. - city")
        XCTAssertEqual(locationObjectFromMeeting.houseNumber, meetingUnderTest.houseNumber, "Location object generated from meeting incorrect. - houseNumber")
        XCTAssertEqual(locationObjectFromMeeting.postalCode, meetingUnderTest.postalCode, "Location object generated from meeting incorrect. - postalCode")
        XCTAssertEqual(locationObjectFromMeeting.streetName, meetingUnderTest.streetName, "Location object generated from meeting incorrect. - streetname")
    }
    
    func testShortDateNotation() {
        //when
        let shortDateNotation = DateUtil.shortDateNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation, "23/12/1998", "DateUtil.shortDateNotation failed.")
    }
    
    func testDayNotation() {
        //when
        let shortDateNotation = DateUtil.dayNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation, "23", "DateUtil.shortDateNotation failed.")
    }
    
    func testShortMonthDateNotation() {
        //when
        let shortDateNotation = DateUtil.shortMonthDateNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation.lowercased(), "dec", "DateUtil.shortDateNotation failed.")
    }
}
