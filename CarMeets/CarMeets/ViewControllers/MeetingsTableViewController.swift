//
//  MeetingsTableViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingsTableViewController: UITableViewController {
    private let notificationCenter: NotificationCenter = .default
    
    /**
     De lijst van Meeting objecten die in de table weergegeven moeten worden.
     */
    var meetings = [Meeting]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isFavourites = (self.navigationItem.title ?? "Meetinglijst") == "Favorietenlijst"
        
        if (isFavourites && !KeyChainUtil.isUserLoggedIn()) {
            MessageUtil.showToast(message: "Voor deze functie moet u aangemeld zijn.", durationInSeconds: 1.0, controller: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observen op meetings
        notificationCenter.addObserver(self,
                                       selector: #selector(meetingsChanged),
                                       name: .meetingsChanged,
                                       object: nil
        )
        
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
    @objc private func meetingsChanged(_ notification: Notification) {
        guard let meetings = notification.object as? [Meeting] else {
            //failed
            return
        }
        
        let isFavourites = (self.navigationItem.title ?? "Meetinglijst") == "Favorietenlijst"
        
        if (isFavourites) {
            self.updateUI(with: ListFilterUtil.getUserFavourites(fromMeetingList: meetings))
        } else {
            self.updateUI(with: meetings)
        }
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
        
        //POC: date correct opgehaald
        //cell.location = DateUtil.shortDateNotation(from: meetings[indexPath.row].date)
 
        //anders artifacts bij het initieel loaden
        meetingTableCell.layoutSubviews()
    }
    
    /**
     Refresht de lijst zijn data met de meegeven lijst.
     
     - Parameter with: de lijst waarmee de table gevult moet worden
     */
    func updateUI(with meetings: [Meeting]) {
        DispatchQueue.main.async {
            self.meetings = meetings
            self.tableView.reloadData()
            
            //aantal meetings in komende 7D instellen
            if (FavouritesUtil.userFavouritesInNext7Days(fromMeetingList: meetings) > 0){
                self.tabBarController?.tabBar.items?[1].badgeValue = String(FavouritesUtil.userFavouritesInNext7Days(fromMeetingList: meetings))
            } else {
                //niets tonen
                self.tabBarController?.tabBar.items?[1].badgeValue = nil
            }
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
            meetingDetailViewController.meetings = meetings
        }
    }
}
