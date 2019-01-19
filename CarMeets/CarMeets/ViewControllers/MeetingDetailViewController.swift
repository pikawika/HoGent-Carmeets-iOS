//
//  MeetingDetailViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingDetailViewController: UIViewController {
    
    var meeting: Meeting!
    
    /**
     De lijst van Meeting objecten die in de table weergegeven moeten worden.
     */
    var meetings = [Meeting]()
    
    private let notificationCenter: NotificationCenter = .default
    
    @IBOutlet weak var meetingImageView: UIImageView!
    
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amountGoingLabel: UILabel!
    @IBOutlet weak var amountLikedLabel: UILabel!
    @IBOutlet weak var goingSwitch: UISwitch!
    @IBOutlet weak var likeSwitch: UISwitch!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observen op meetings
        notificationCenter.addObserver(self,
                                       selector: #selector(meetingsChanged),
                                       name: .meetingsChanged,
                                       object: nil
        )
        
        updateUI()
    }
    
    /**
     Zorgt er voor dat de UI geupdate wordt wanneer de lijst veranderd.
     */
    @objc private func meetingsChanged(_ notification: Notification) {
        guard let meetings = notification.object as? [Meeting] else {
            //failed
            return
        }
        
        let isFavourites = (self.tabBarController?.selectedIndex ?? 0) == 1
        
        if (isFavourites) {
            self.meetings = ListFilterUtil.getUserFavourites(fromMeetingList: meetings)
        } else {
            self.meetings = meetings
        }
        
        if let meeting = ListFilterUtil.getMeetingWithID(fromMeetingList: meetings, withMeetingId: meeting.meetingId)
        {
            self.meeting = meeting
            DispatchQueue.main.async {
                self.updateUI()
            }
            
        }
        
    }
    
    func updateUI() {
        //image
        MeetingController.shared.fetchMeetingImage(imageName: meeting.imageName) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.meetingImageView.image = image
            }
        }
        
        //dag
        dateDayLabel.text = DateUtil.dayNotation(from: meeting.date)
        //maand
        dateMonthLabel.text = DateUtil.shortMonthDateNotation(from: meeting.date)
        //title
        titleLabel.text = meeting.title
        //subtitle
        subtitleLabel.text = meeting.subtitle
        //description
        descriptionLabel.text = meeting.description
        //location
        locationLabel.attributedText = LocationUtil.fullAdressNotationWithIcon(from: meeting.location())
        //categories
        categoriesLabel.attributedText = CategoriesUtil.listNotation(from: meeting.categories)
        
        //aantal going instellen
        amountGoingLabel.attributedText = FavouritesUtil.amountGoingNotation(fromMeeting: meeting)
        
        //of user al dan niet gaat instellen
        goingSwitch.setOn(FavouritesUtil.isUserGoing(toMeeting: meeting), animated: true)
        
        //of user al dan niet geliked heeft instellen
        likeSwitch.setOn(FavouritesUtil.isUserLiking(meeting: meeting), animated: true)
        
        //aantal liked instellen
        amountLikedLabel.attributedText = FavouritesUtil.amountLikedNotation(fromMeeting: meeting)
        
        if ((meeting.website ?? "").isEmpty) {
            websiteButton.isHidden = true
        }
    }
    
    @IBAction func goingClicked(_ sender: Any) {
        if (KeyChainUtil.isUserLoggedIn()) {
            //toggle going request formaat maken
            let toggleGoingRequest = ToggleGoingRequest.init(meetingId: meeting.meetingId)
            
            MeetingController.shared.toggleGoingForMeeting(withToggleGoingRequest: toggleGoingRequest)
        } else {
            MessageUtil.showToast(message: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self)
        }
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        if (KeyChainUtil.isUserLoggedIn()) {
            //toggle like request formaat maken
            let toggleLikeRequest = ToggleLikeRequest.init(meetingId: meeting.meetingId)
            
            MeetingController.shared.toggleLikedForMeeting(withToggleLikedRequest: toggleLikeRequest)
        } else {
            MessageUtil.showToast(message: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self)
        }
    }
    
    @IBAction func navigationButtonClicked(_ sender: UIButton) {
        SharedApplicationUtil.openNavigation(for: meeting.location())
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        meeting = ListFilterUtil.getNextMeeting(fromMeetingList: meetings, withCurrentMeeting: meeting)
        
        updateUI()
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        meeting = ListFilterUtil.getPreviousMeeting(fromMeetingList: meetings, withCurrentMeeting: meeting)
        
        updateUI()
    }
    
    @IBAction func addToCalanderClicked(_ sender: Any) {
        CalanderUtil.addEventToCalendar(
            title: meeting.title,
            description: meeting.description,
            location: LocationUtil.fullAdressNotation(from: meeting.location()),
            startDate: meeting.date,
            endDate: meeting.date,
            controller: self)
    }
    
    @IBAction func visitWebsiteClicked(_ sender: Any) {
        SharedApplicationUtil.openWebsite(url: meeting.website ?? "")
    }
    
}
