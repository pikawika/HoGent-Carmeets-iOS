//
//  MeetingsTableViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

class MeetingsTableViewController: UITableViewController {
    
    var meetings = [Meeting]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MeetingController.shared.fetchMeetings { (meetings) in
            if let meetings = meetings {
                self.updateUI(with: meetings)
            }
        }
        
        self.tableView.register(MeetingTableCell.self, forCellReuseIdentifier: "customMeetingTableCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //+- 16/9 verhouding voor 40% van een iphone x scherm
        self.tableView.estimatedRowHeight = 180
        
        //de footer is niets (ipv nog vullen met lege lijst items)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customMeetingTableCell") as! MeetingTableCell
        
        configureMeetingTableCell(cell, forItemAt: indexPath)

        return cell
    }
    
    func configureMeetingTableCell(_ cell: MeetingTableCell, forItemAt indexPath: IndexPath) {
        cell.meetingImageName = meetings[indexPath.row].imageName
        cell.title = meetings[indexPath.row].title
        cell.subtitle = meetings[indexPath.row].subtitle
        cell.location = meetings[indexPath.row].postalCode + ", " + meetings[indexPath.row].city
        
        
        //POC: date correct opgehaald
        //cell.location = DateUtil.dateToShortNotation(date: meetings[indexPath.row].date)
 
        
        cell.layoutSubviews()
    }
    
    func updateUI(with meetings: [Meeting]) {
        DispatchQueue.main.async {
            self.meetings = meetings
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listToDetalSegue", sender: self)
    }
}
