//
//  AccountController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

class AccountController {
    
    static let shared = AccountController()
    
    /**
     Probeert een gebruiker aan te melden of geeft de error melding terug.
     
     - Returns: dictionary met een bool en een string waarbij de bool loggedIn en de string al dan niet melding van de server.
     */
    func login(withCredentials loginRequest: LoginRequest, completion: @escaping ((Bool, String)) -> Void) {
        let allMeetingsURL = NetworkConstants.baseApiUsersURL.appendingPathComponent("login")
        var request = URLRequest(url: allMeetingsURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(loginRequest)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let tokenResponse = try? jsonDecoder.decode(TokenResponse.self, from: data) {
                
                //iets teruggekregen (token of error message)
                if let token = tokenResponse.token {
                    DispatchQueue.main.async {
                        completion((true, token))
                    }
                }
                else if let errorMessage = tokenResponse.errorMessage {
                    DispatchQueue.main.async {
                        completion((false, errorMessage))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion((false, "aanmelden mislukt"))
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    completion((false, "aanmelden mislukt"))
                }
            }
        }
        task.resume()
    }

}
