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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
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
        // #warning Incomplete implementation, return the number of rows
        return cellData.count
    }
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
