//
//  MeetingTableCell.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class MeetingTableCell: UITableViewCell {
    
    //nullable zodanig niet crasen bij verkeerd doorgeven of niet doorgeven bepaalde
    var meetingImageName: String?
    var title: String?
    var subtitle: String?
    var location: String?
    
    var meetingImageView: UIImageView = {
        var imageView = UIImageView()
        //optie nodig om constraint correct te kunenn gebruiken
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //default image instellen voor bij laden niet leeg te zijn
        imageView.image = #imageLiteral(resourceName: "img_logo")
        return imageView
    }()
    
    var titleView: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    }()
    
    var subtitleView: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        return label
    }()
    
    var locationView: UILabel = {
        var label = UILabel()
        //optie nodig om constraint correct te kunenn gebruiken
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //elementen toevoegen aan lijst item
        self.addSubview(meetingImageView)
        self.addSubview(titleView)
        self.addSubview(subtitleView)
        self.addSubview(locationView)
        
        //img constrainen met left top en bootom van parent en 40% width
        meetingImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        meetingImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        meetingImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        //40% width in beslag nemen
        meetingImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        //height is in 16:9 verhouding
        meetingImageView.heightAnchor.constraint(equalTo: self.meetingImageView.widthAnchor, multiplier: (9/16)).isActive = true
        
        //title rechts van img bovenaan
        titleView.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        //subtitle rechts van img onder title
        subtitleView.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        subtitleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        subtitleView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 5).isActive = true
        
        //location rechts van img onder subtitle
        locationView.leftAnchor.constraint(equalTo: self.meetingImageView.rightAnchor, constant: 10).isActive = true
        locationView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        locationView.topAnchor.constraint(equalTo: self.subtitleView.bottomAnchor, constant: 5).isActive = true
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
            titleView.text = title
        }
        
        if let subtitle = subtitle {
            subtitleView.text = subtitle
        }
        
        if let location = location {
            //Zie bronnen voor source.
            //Create Attachment
            let imageAttachment =  NSTextAttachment()
            imageAttachment.image = #imageLiteral(resourceName: "ic_location_small")
            //Set bound to reposition
            let imageOffsetY:CGFloat = -5.0;
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            //Create string with attachment
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            //Initialize mutable string
            let completeText = NSMutableAttributedString(string: "")
            //Add image to mutable string
            completeText.append(attachmentString)
            //Add your text to mutable string
            let  textAfterIcon = NSMutableAttributedString(string: location)
            completeText.append(textAfterIcon)
            locationView.attributedText = completeText
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented :(")
    }
}
