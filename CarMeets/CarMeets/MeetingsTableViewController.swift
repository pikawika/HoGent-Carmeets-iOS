//
//  MeetingsTableViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import UIKit

struct CellData {
    let meetingImage : UIImage
    let title: String
    let subtitle: String
    let location: String
}

class MeetingsTableViewController: UITableViewController {
    
    var cellData = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellData = [CellData.init(meetingImage: #imageLiteral(resourceName: "img_car"), title: "titel 1", subtitle: "subtitel 1", location: "9260, Schellebelle"), CellData.init(meetingImage: #imageLiteral(resourceName: "img_car"), title: "titel 2", subtitle: "subtitel 2", location: "9260, Schellebelle")]
        
        self.tableView.register(MeetingTableCell.self, forCellReuseIdentifier: "customMeetingTableCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //+- 16/9 verhouding voor 40% van een iphone x scherm
        self.tableView.estimatedRowHeight = 180
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customMeetingTableCell") as! MeetingTableCell
        
        cell.meetingImage = cellData[indexPath.row].meetingImage
        cell.title = cellData[indexPath.row].title
        cell.subtitle = cellData[indexPath.row].subtitle
        cell.location = cellData[indexPath.row].location
        cell.layoutSubviews()
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listToDetalSegue", sender: self)
    }
 

    

}
