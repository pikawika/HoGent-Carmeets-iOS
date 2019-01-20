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
     Probeert een gebruiker aan te melden of geeft de error melding terug indien niet succesvol.
     
     - Returns: dictionary met een bool en een string waarbij de bool loggedIn en de string al dan niet melding van de server.
     */
    func login(withCredentials loginRequest: LoginRequest, completion: @escaping ((Bool, String)) -> Void) {
        let loginURL = NetworkConstants.baseApiUsersURL.appendingPathComponent("login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(loginRequest)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let tokenResponse = try? jsonDecoder.decode(TokenResponse.self, from: data) {
                
                //iets teruggekregen (token of error message checken)
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Aangemeld"))
                }
                else if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                }
                else {
                    completion((false, "Aanmelden mislukt"))
                }
                
            } else {
                completion((false, "Aanmelden mislukt"))
            }
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker te registreren of geeft de error melding terug indien niet succesvol.
     
     - Returns: dictionary met een bool en een string waarbij de bool loggedIn en de string al dan niet melding van de server.
     */
    func register(withAccountDetails registerRequest: RegisterRequest, completion: @escaping ((Bool, String)) -> Void) {
        let registerUrl = NetworkConstants.baseApiUsersURL.appendingPathComponent("registreer")
        var request = URLRequest(url: registerUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(registerRequest)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let tokenResponse = try? jsonDecoder.decode(TokenResponse.self, from: data) {
                
                //iets teruggekregen (token of error message checken)
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Geregistreerd"))
                }
                else if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                }
                else {
                    completion((false, "Registreren mislukt"))
                }
            } else {
                completion((false, "Registreren mislukt"))
            }
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker zijn username te wijzigen of geeft de error melding terug indien niet succesvol.
     
     - Returns: dictionary met een bool en een string waarbij de bool succes en de string al dan niet melding van de server representeert.
     */
    func changeUsername(withNewUsernameDetails changeUsernameRequest: ChangeUsernameRequest, completion: @escaping ((Bool, String)) -> Void) {
        let changePasswordURL = NetworkConstants.baseApiUsersURL.appendingPathComponent("changeUsername")
        var request = URLRequest(url: changePasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(changeUsernameRequest)
        request.httpBody = jsonData
        request.setValue("Bearer " + KeyChainUtil.getTokenFromKeychain(), forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let tokenResponse = try? jsonDecoder.decode(TokenResponse.self, from: data) {
                
                //iets teruggekregen (token of error message checken)
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Gebruikersnaam gewijzigd!"))
                }
                else if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                }
                else {
                    completion((false, "Gebruikersnaam wijzigen mislukt"))
                }
            } else {
                completion((false, "Gebruikersnaam wijzigen mislukt"))
            }
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker zijn wachtwoord te wijzigen of geeft de error melding terug indien niet succesvol.
     
     - Returns: dictionary met een bool en een string waarbij de bool succes en de string al dan niet melding van de server representeert.
     */
    func changePassword(withNewPasswordDetails changePasswordRequest: ChangePasswordRequest, completion: @escaping ((Bool, String)) -> Void) {
        let changePasswordURL = NetworkConstants.baseApiUsersURL.appendingPathComponent("changePassword")
        var request = URLRequest(url: changePasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(changePasswordRequest)
        request.httpBody = jsonData
        request.setValue("Bearer " + KeyChainUtil.getTokenFromKeychain(), forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let tokenResponse = try? jsonDecoder.decode(TokenResponse.self, from: data) {
                
                //iets teruggekregen (token of error message checken)
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Wachtwoord gewijzigd!"))
                }
                else if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                }
                else {
                    completion((false, "Wachtwoord wijzigen mislukt"))
                }
            } else {
                completion((false, "Wachtwoord wijzigen mislukt"))
            }
        }
        task.resume()
    }
    
}
