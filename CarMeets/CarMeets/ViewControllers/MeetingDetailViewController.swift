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
        
        
    }

}
