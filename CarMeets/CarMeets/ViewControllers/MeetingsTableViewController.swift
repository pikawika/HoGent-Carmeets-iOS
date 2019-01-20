//
//  MeetingsTableViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingsTableViewController: UITableViewController {
    
    /**
     De lijst van Meeting objecten die in de table weergegeven moeten worden.
     */
    private var meetings = [Meeting]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isFavourites = (self.navigationItem.title ?? "Meetinglijst") == "Favorietenlijst"
        
        if (isFavourites && !KeyChainUtil.isUserLoggedIn()) {
            MessageUtil.showToast(withMessage: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self) { () in
                //ga naar login
                self.performSegue(withIdentifier: "favouritesToLoginSegue", sender: self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observen op meetings
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(meetingsChanged),
                                       name: .meetingsChanged,
                                       object: nil
        )
        
        syncMeetingsFromController()
        
        if (meetings.count == 0) {
            //meetings ophalen -> observer zal automatisch UI updaten
            MeetingController.shared.fetchMeetings()
        }
        
        self.tableView.register(MeetingTableCell.self, forCellReuseIdentifier: "customMeetingTableCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //+- 16/9 verhouding voor 40% van een iphone x scherm
        self.tableView.estimatedRowHeight = 180
        
        //de footer is niets (ipv nog vullen met lege lijst items)
        tableView.tableFooterView = UIView()
    }
    
    /**
     Zorgt er voor dat de UI geupdate wordt wanneer de lijst veranderd.
     */
    @objc private func meetingsChanged() {
        syncMeetingsFromController()
        
        self.updateUI()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customMeetingTableCell") as! MeetingTableCell
        
        //stell de cell in
        configureMeetingTableCell(meetingTableCell: cell, forItemAt: indexPath)

        return cell
    }
    
    /**
     Stelt de content van een MeetingTableCell in.
     
     - Parameter meetingTableCell: de te configureren cell.
     
     - Parameter forItemAt: de index van de meeting in de meetings array waarmee de cell gevuld moet worden.
     */
    func configureMeetingTableCell(meetingTableCell: MeetingTableCell, forItemAt indexPath: IndexPath) {
        meetingTableCell.meetingImageName = meetings[indexPath.row].imageName
        meetingTableCell.title = meetings[indexPath.row].title
        meetingTableCell.subtitle = meetings[indexPath.row].subtitle
        meetingTableCell.location = meetings[indexPath.row].location()
 
        //anders artifacts bij het initieel loaden
        meetingTableCell.layoutSubviews()
    }
    
    /**
     Refresht de lijst zijn data met de meegeven lijst.
     
     - Parameter withMeetings: de lijst van meetings waarmee de table gevult moet worden.
     */
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listToDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToDetailSegue" {
            let meetingDetailViewController = segue.destination as! MeetingDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            meetingDetailViewController.meeting = meetings[index]
        }
        
        if segue.identifier == "favouritesToLoginSegue" {
            let loginViewController = segue.destination as! LoginViewController
            loginViewController.backButtonVisible = false
        }
    }
    
    private func syncMeetingsFromController() {
        let isFavourites = (self.navigationItem.title ?? "Meetinglijst") == "Favorietenlijst"
        
        if (isFavourites) {
            meetings = ListFilterUtil.getUserFavourites(fromMeetingList: MeetingController.shared.meetings)
        } else {
            meetings = MeetingController.shared.meetings
        }
    }
}
