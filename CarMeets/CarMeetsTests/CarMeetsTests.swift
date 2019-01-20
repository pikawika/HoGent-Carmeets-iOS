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
    var meetingUnderTestUserLiked: Meeting!
    var meetingUnderTestUserGoing: Meeting!
    var meetingUnderTestUserLikedAndGoing: Meeting!
    var dateUnderTest: Date!
    
    let validToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YmRlZjlmOTFmNTlhMDAwMTMwMmY1YmUiLCJ1c2VybmFtZSI6InNuZWxsZW5lZGR5Iiwicm9sZSI6InN0YW5kYWFyZCIsImV4cCI6MjQwOTk5OTY5NiwiaWF0IjoxNTQ1OTk5Njk2fQ.3J6g0ccP9l8EiHsFfKtGDTvlxc0HY15WXBX30J7Jw4g"
    let validTokenId = "5bdef9f91f59a0001302f5be"
    let validTokenUsername = "snelleneddy"
    
    let invalidToken = "nope"
    let invalidTokenDefaultUsername = "gebruiker"
    let invalidTokenDefaultId = "-1"

    override func setUp() {
        meetingUnderTest = Meeting.init(meetingId: "1", imageName: "1", title: "title1", subtitle: "subtitle1", description: "description1", date: Date(), city: "Schellebelle", postalCode: "9260", streetName: "Dendermondsesteeweng", houseNumber: "92", categories: ["Cat1", "Cat2"], listUsersGoing: ["1","2","3"], listUsersLiked: ["3","4","5"], website: "https://lennertbontinck.com/")
        
        meetingUnderTestUserLiked = Meeting.init(meetingId: "2", imageName: "2", title: "title2", subtitle: "subtitle2", description: "description2", date: Date(), city: "Schellebelle", postalCode: "9260", streetName: "Dendermondsesteeweng", houseNumber: "92", categories: ["Cat1", "Cat2"], listUsersGoing: ["1","2","3"], listUsersLiked: ["5bdef9f91f59a0001302f5be","4","5"], website: "https://lennertbontinck.com/")
        
        meetingUnderTestUserGoing = Meeting.init(meetingId: "3", imageName: "v", title: "title3", subtitle: "subtitle3", description: "description3", date: Date(), city: "Schellebelle", postalCode: "9260", streetName: "Dendermondsesteeweng", houseNumber: "92", categories: ["Cat1", "Cat2"], listUsersGoing: ["5bdef9f91f59a0001302f5be","2","3"], listUsersLiked: ["3","4","5"], website: "https://lennertbontinck.com/")
        
        meetingUnderTestUserLikedAndGoing = Meeting.init(meetingId: "4", imageName: "4", title: "title4", subtitle: "subtitle4", description: "description4", date: Date(), city: "Schellebelle", postalCode: "9260", streetName: "Dendermondsesteeweng", houseNumber: "92", categories: ["Cat1", "Cat2"], listUsersGoing: ["1","2","5bdef9f91f59a0001302f5be"], listUsersLiked: ["5bdef9f91f59a0001302f5be","4","5"], website: "https://lennertbontinck.com/")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateUnderTest = formatter.date(from: "1998/12/23")
        
        
    }

    override func tearDown() {
        meetingUnderTest = nil
        KeyChainUtil.clearKeychain()
    }

    func testLocationUtil_isGeneratableFromMeetingObject() {
        //when
        let locationObjectFromMeeting = meetingUnderTest.location()
    
        //then
        XCTAssertEqual(locationObjectFromMeeting.city, meetingUnderTest.city, "Location object generated from meeting incorrect. - city")
        XCTAssertEqual(locationObjectFromMeeting.houseNumber, meetingUnderTest.houseNumber, "Location object generated from meeting incorrect. - houseNumber")
        XCTAssertEqual(locationObjectFromMeeting.postalCode, meetingUnderTest.postalCode, "Location object generated from meeting incorrect. - postalCode")
        XCTAssertEqual(locationObjectFromMeeting.streetName, meetingUnderTest.streetName, "Location object generated from meeting incorrect. - streetname")
    }
    
    func testDateUtil_ShortDateNotation() {
        //when
        let shortDateNotation = DateUtil.shortDateNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation, "23/12/1998", "DateUtil.shortDateNotation failed.")
    }
    
    func testDateUtil_DayNotation() {
        //when
        let shortDateNotation = DateUtil.dayNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation, "23", "DateUtil.shortDateNotation failed.")
    }
    
    func testDateUtil_ShortMonthDateNotation() {
        //when
        let shortDateNotation = DateUtil.shortMonthDateNotation(fromDate: dateUnderTest)
        
        //then
        XCTAssertEqual(shortDateNotation.lowercased(), "dec", "DateUtil.shortDateNotation failed.")
    }
    
    func testKeyChainUtil_setAndGet() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
    }
    
    func testTokenUtil_usernameCorrectFromValidToken() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(TokenUtil.getUsernameFromToken(), validTokenUsername, "KeyChainUtil.getTokenFromKeychain failed.")
    }
    
    func testTokenUtil_usernameDefaultsWithInvalidToken() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: invalidToken)
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), invalidToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(TokenUtil.getUsernameFromToken(), invalidTokenDefaultUsername, "KeyChainUtil.getTokenFromKeychain failed.")
    }
    
    func testTokenUtil_idCorrectFromValidToken() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(TokenUtil.getUserIdFromToken(), validTokenId, "KeyChainUtil.getTokenFromKeychain failed.")
    }
    
    func testTokenUtil_idDefaultsWithInvalidToken() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: invalidToken)
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), invalidToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(TokenUtil.getUserIdFromToken(), invalidTokenDefaultId, "KeyChainUtil.getTokenFromKeychain failed.")
    }
    
    func testListFilterUtil_favourites_returnsLikedMeetings() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        let favourites = ListFilterUtil.getUserFavourites(fromMeetingList: [meetingUnderTest, meetingUnderTestUserLiked])
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(favourites.count, 1, "ListFilterUtil.getUserFavourites failed.")
        XCTAssertEqual(favourites[0].meetingId, meetingUnderTestUserLiked.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_favourites_returnsGoingMeetings() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        let favourites = ListFilterUtil.getUserFavourites(fromMeetingList: [meetingUnderTest, meetingUnderTestUserGoing])
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(favourites.count, 1, "ListFilterUtil.getUserFavourites failed.")
        XCTAssertEqual(favourites[0].meetingId, meetingUnderTestUserGoing.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_favourites_returnsLikedAndGoingMeetings() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        let favourites = ListFilterUtil.getUserFavourites(fromMeetingList: [meetingUnderTest, meetingUnderTestUserLikedAndGoing])
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(favourites.count, 1, "ListFilterUtil.getUserFavourites failed.")
        XCTAssertEqual(favourites[0].meetingId, meetingUnderTestUserLikedAndGoing.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_favourites_returnsLikedAndGoingMeetings_mixOfLikeAndGoing() {
        //when
        KeyChainUtil.setTokenInKeychain(withValue: validToken)
        
        let favourites = ListFilterUtil.getUserFavourites(fromMeetingList: [meetingUnderTest, meetingUnderTestUserLikedAndGoing, meetingUnderTestUserGoing, meetingUnderTestUserLiked])
        
        //then
        XCTAssertEqual(KeyChainUtil.getTokenFromKeychain(), validToken, "KeyChainUtil.getTokenFromKeychain failed.")
        XCTAssertEqual(favourites.count, 3, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_nextMeeting_returnsNextMeeting() {
        //when
        let meetings = [meetingUnderTest, meetingUnderTestUserLikedAndGoing, meetingUnderTestUserGoing, meetingUnderTestUserLiked]
        let currentMeeting = meetingUnderTest!
        let nextMeeting = meetingUnderTestUserLikedAndGoing!
        
        let acquiredNextMeeting = ListFilterUtil.getNextMeeting(fromMeetingList: meetings as! [Meeting], withCurrentMeeting: currentMeeting)!
        
        //then
        XCTAssertEqual(acquiredNextMeeting.meetingId, nextMeeting.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_nextMeeting_returnsFirstMeetingAddEndOfArray() {
        //when
        let meetings = [meetingUnderTest, meetingUnderTestUserLikedAndGoing, meetingUnderTestUserGoing, meetingUnderTestUserLiked]
        let currentMeeting = meetingUnderTestUserLiked!
        let nextMeeting = meetingUnderTest!
        
        let acquiredNextMeeting = ListFilterUtil.getNextMeeting(fromMeetingList: meetings as! [Meeting], withCurrentMeeting: currentMeeting)!
        
        //then
        XCTAssertEqual(acquiredNextMeeting.meetingId, nextMeeting.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_previousMeeting_returnsPreviousMeeting() {
        //when
        let meetings = [meetingUnderTest, meetingUnderTestUserLikedAndGoing, meetingUnderTestUserGoing, meetingUnderTestUserLiked]
        let currentMeeting = meetingUnderTestUserGoing!
        let nextMeeting = meetingUnderTestUserLikedAndGoing!
        
        let acquiredNextMeeting = ListFilterUtil.getPreviousMeeting(fromMeetingList: meetings as! [Meeting], withCurrentMeeting: currentMeeting)!
        
        //then
        XCTAssertEqual(acquiredNextMeeting.meetingId, nextMeeting.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
    func testListFilterUtil_previousMeeting_returnsLastMeetingAddStartOfArray() {
        //when
        let meetings = [meetingUnderTest, meetingUnderTestUserLikedAndGoing, meetingUnderTestUserGoing, meetingUnderTestUserLiked]
        let currentMeeting = meetingUnderTest!
        let nextMeeting = meetingUnderTestUserLiked!
        
        let acquiredNextMeeting = ListFilterUtil.getPreviousMeeting(fromMeetingList: meetings as! [Meeting], withCurrentMeeting: currentMeeting)!
        
        //then
        XCTAssertEqual(acquiredNextMeeting.meetingId, nextMeeting.meetingId, "ListFilterUtil.getUserFavourites failed.")
    }
    
}
