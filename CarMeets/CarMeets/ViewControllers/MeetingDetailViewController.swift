//
//  MeetingDetailViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.

import UIKit

class MeetingDetailViewController: UIViewController {
    
    /**
     Het meeting object waarvan de detailpagina weergeven moet worden.
     */
    var meeting: Meeting!
    
    /**
     De lijst van Meeting objecten waarnaar gebruiker kan verder of terugnavigeren.
     */
    private var meetings = [Meeting]()
    
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
    @IBOutlet weak var addtoCalanderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observen op meetings
        notificationCenter.addObserver(self,
                                       selector: #selector(meetingsChanged),
                                       name: .meetingsChanged,
                                       object: nil
        )
        
        syncMeetingsFromController()
        
        updateUI()
    }
    
    /**
     Zorgt er voor dat de UI geupdate wordt wanneer de lijst veranderd.
     */
    @objc private func meetingsChanged() {
        if let meeting = ListFilterUtil.getMeetingWithID(fromMeetingList: MeetingController.shared.meetings, withMeetingId: meeting.meetingId)
        {
            syncMeetingsFromController()
            
            self.meeting = meeting
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    private func updateUI() {
        //image
        MeetingController.shared.fetchMeetingImage(imageName: meeting.imageName) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.meetingImageView.image = image
            }
        }
        
        //dag
        dateDayLabel.text = DateUtil.dayNotation(fromDate: meeting.date)
        //maand
        dateMonthLabel.text = DateUtil.shortMonthDateNotation(fromDate: meeting.date)
        //title
        titleLabel.text = meeting.title
        //subtitle
        subtitleLabel.text = meeting.subtitle
        //description
        descriptionLabel.text = meeting.description
        //location
        locationLabel.attributedText = LocationUtil.fullAdressNotationWithIcon(fromLocation: meeting.location())
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
        
        //indien geen website
        if ((meeting.website ?? "").isEmpty) {
            websiteButton.isHidden = true
        } else {
            websiteButton.isHidden = false
        }
        
        //indien reeds in kalander
        CalanderUtil.isEventInCalander(withMeetingData: meeting) { (eventAlreadyInCalander) in
            DispatchQueue.main.async {
                if (eventAlreadyInCalander){
                    //toegevoegd aan kalander
                    self.setAlreadyInCalander()
                } else {
                    self.setNotAlreadyInCalander()
                }
            }
        }
    }
    
    @IBAction func goingClicked(_ sender: Any) {
        if (KeyChainUtil.isUserLoggedIn()) {
            //toggle going request formaat maken
            let toggleGoingRequest = ToggleGoingRequest.init(meetingId: meeting.meetingId)
            
            MeetingController.shared.toggleGoingForMeeting(withToggleGoingRequest: toggleGoingRequest)
        } else {
            MessageUtil.showToast(withMessage: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self) { () in
                //ga naar login
                self.performSegue(withIdentifier: "detailToLoginSegue", sender: self)
            }
        }
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        if (KeyChainUtil.isUserLoggedIn()) {
            //toggle like request formaat maken
            let toggleLikeRequest = ToggleLikeRequest.init(meetingId: meeting.meetingId)
            
            MeetingController.shared.toggleLikedForMeeting(withToggleLikedRequest: toggleLikeRequest)
        } else {
            MessageUtil.showToast(withMessage: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self) { () in
                //ga naar login
                self.performSegue(withIdentifier: "detailToLoginSegue", sender: self)
            }
        }
    }
    
    @IBAction func navigationButtonClicked(_ sender: UIButton) {
        SharedApplicationUtil.openNavigation(withMarkerOnLocation: meeting.location())
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        if let meeting = ListFilterUtil.getNextMeeting(fromMeetingList: meetings, withCurrentMeeting: meeting) {
            self.meeting = meeting
            updateUI()
        }
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        if let meeting = ListFilterUtil.getPreviousMeeting(fromMeetingList: meetings, withCurrentMeeting: meeting) {
            self.meeting = meeting
            updateUI()
        }
    }
    
    @IBAction func addToCalanderClicked(_ sender: Any) {
        //proberen inloggen met de userdata
        CalanderUtil.addEventToCalendar(withMeetingData: meeting) { (response) in
            DispatchQueue.main.async {
                if (response.0){
                    //toegevoegd aan kalander
                    self.setAlreadyInCalander()
                }
                
                MessageUtil.showToast(withMessage: response.1, durationInSeconds: 2, controller: self)
            }
        }
    }
    
    @IBAction func visitWebsiteClicked(_ sender: Any) {
        SharedApplicationUtil.openWebsite(withUrl: meeting.website ?? "")
    }
    
    private func setAlreadyInCalander() {
        addtoCalanderButton.setTitle("Reeds in kalander!", for: .normal)
        addtoCalanderButton.isEnabled = false
        addtoCalanderButton.backgroundColor = #colorLiteral(red: 0.533352657, green: 0.0900933148, blue: 0.2168095011, alpha: 1)
    }
    
    private func setNotAlreadyInCalander() {
        addtoCalanderButton.setTitle("Toevoegen aan kalender", for: .normal)
        addtoCalanderButton.isEnabled = true
        addtoCalanderButton.backgroundColor = #colorLiteral(red: 0.9079759121, green: 0.1492268741, blue: 0.3642436862, alpha: 1)
    }
    
    private func syncMeetingsFromController() {
        let isFavourites = (self.tabBarController?.selectedIndex ?? 0) == 1
        
        if (isFavourites) {
            meetings = ListFilterUtil.getUserFavourites(fromMeetingList: MeetingController.shared.meetings)
        } else {
            meetings = MeetingController.shared.meetings
        }
    }
    
}
