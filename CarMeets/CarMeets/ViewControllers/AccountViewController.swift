//
//  AccountViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //back button niet zichtbaar - login terug mag niet hier.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
    }
    
    @IBAction func changeUsernameClicked(_ sender: Any) {
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
        KeyChainUtil.clearKeychain()
        //ga terug naar login
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func updateUI() {
        usernameLabel.text = TokenUtil.getUsernameFromToken()
    }
}
