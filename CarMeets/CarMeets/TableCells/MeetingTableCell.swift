//
//  MeetingTableCell.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.

//  Source for inspiration (edited to suite my needs | also mentioned in Readme)
//      https://www.youtube.com/watch?v=YwE3_hMyDZA

import Foundation
import UIKit

class MeetingTableCell: UITableViewCell {
    
    //nullable zodanig niet crasen bij verkeerd doorgeven of niet doorgeven bepaalde
    var meetingImageName: String?
    var title: String?
    var subtitle: String?
    var location: Location?
    
    var meetingImageView: UIImageView = {
        var imageView = UIImageView()
        //optie nodig om constraint correct te kunenn gebruiken
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //default image instellen voor bij laden niet leeg te zijn
        imageView.image = #imageLiteral(resourceName: "img_logo")
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    }()
    
    var subtitleLabel: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.numberOfLines = 2
        return label
    }()
    
    var locationLabel: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //ipad groter font
        if (UIScreen.main.traitCollection.isIpad) {
            titleLabel.font = titleLabel.font.withSize(30)
            subtitleLabel.font = subtitleLabel.font.withSize(28)
            locationLabel.font = locationLabel.font.withSize(20)
        }
        
        //elementen toevoegen aan lijst item
        self.addSubview(meetingImageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(locationLabel)
        
        //img constrainen met left top en bootom van parent en 40% width
        meetingImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        meetingImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10).isActive = true
        meetingImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
        //40% width in beslag nemen
        meetingImageView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.4).isActive = true
        //height is in 16:9 verhouding
        meetingImageView.heightAnchor.constraint(lessThanOrEqualTo: self.meetingImageView.widthAnchor, multiplier: (0.56)).isActive = true
        //in het midden uitlijnen voor kleine schermen waar tekst groter dan afbeelding hoogte
        meetingImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //max height
        meetingImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        meetingImageView.widthAnchor.constraint(lessThanOrEqualToConstant: ((150)/9)*16).isActive = true
        
        
        //title rechts van img bovenaan
        titleLabel.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        //subtitle rechts van img onder title
        subtitleLabel.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        
        //location rechts van img onder subtitle
        locationLabel.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 5).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //image van de server halen
        if let meetingImageName = meetingImageName {
            MeetingController.shared.fetchMeetingImage(imageName: meetingImageName) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.meetingImageView.image = image
                }
            }
        }
        
        if let title = title {
            titleLabel.text = title
        }
        
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
        }
        
        if let location = location {
            locationLabel.attributedText = LocationUtil.fullCityNotationWithIcon(fromLocation: location)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This is not how you implement this cell.")
    }
}
