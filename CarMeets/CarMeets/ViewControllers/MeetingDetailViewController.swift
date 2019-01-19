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
    
    @IBOutlet weak var meetingImageView: UIImageView!
    
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amountGoingLabel: UILabel!
    @IBOutlet weak var amountLikedLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
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
        
        //aantal liked instellen
        amountLikedLabel.attributedText = FavouritesUtil.amountLikedNotation(fromMeeting: meeting)
        
        if ((meeting.website ?? "").isEmpty) {
            websiteButton.isHidden = true
        }
    }
    
    @IBAction func navigationButtonClicked(_ sender: UIButton) {
        SharedApplicationUtil.openNavigation(for: meeting.location())
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
