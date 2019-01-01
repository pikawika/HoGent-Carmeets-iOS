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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    

    func updateUI() {
        MeetingController.shared.fetchMeetingImage(imageName: meeting.imageName) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.meetingImageView.image = image
            }
        }
    }

}
