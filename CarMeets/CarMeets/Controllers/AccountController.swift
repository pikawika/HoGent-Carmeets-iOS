//
//  AccountController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Controller verantwoordelijk voor het uitvoeren van user gerelateerde functies
 */
class AccountController {
    
    /**
     Controller verantwoordelijk voor het uitvoeren van user gerelateerde functies
     */
    static let shared = AccountController()
    
    /**
     Probeert een gebruiker aan te melden of geeft de error melding terug indien niet succesvol.
     
     - Parameter withCredentials: de credentials van de user die zicht wenst in te loggen
     
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
                
                //iets teruggekregen - token
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Aangemeld"))
                    return
                }
                
                //iets teruggekregen - error
                if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                    return
                }
                
            }
            
            completion((false, "Aanmelden mislukt"))
            
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker te registreren of geeft de error melding terug indien niet succesvol.
     
     - Parameter withAccountDetails: De account gegevens van het account dat je wenst aan te maken.
     
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
                
                //iets teruggekregen - token
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Geregistreerd"))
                    return
                }
                
                //iets teruggekregen - error
                if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                    return
                }
                
            }
            
            completion((false, "Registreren mislukt"))
            
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker zijn username te wijzigen of geeft de error melding terug indien niet succesvol.
     
     - Parameter withNewUsernameDetails: De username gegevens de nieuwe username dat de gebruiker wenst in te stellen.
     
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
                
                //iets teruggekregen - token
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Gebruikersnaam gewijzigd!"))
                    return
                }
                
                //iets teruggekregen - error
                if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                    return
                }
                
                completion((false, "Gebruikersnaam wijzigen mislukt"))
                
            }
        }
        task.resume()
    }
    
    /**
     Probeert een gebruiker zijn wachtwoord te wijzigen of geeft de error melding terug indien niet succesvol.
     
     - Parameter withNewPasswordDetails: De wachtwoords gegevens van de nieuwe username dat de gebruiker wenst in te stellen.
     
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
                
                //iets teruggekregen - token
                if let token = tokenResponse.token {
                    KeyChainUtil.setTokenInKeychain(withValue: token)
                    completion((true, "Wachtwoord gewijzigd!"))
                    return
                }
                
                //iets teruggekregen - error
                if let errorMessage = tokenResponse.errorMessage {
                    completion((false, errorMessage))
                    return
                }
                
                completion((false, "Wachtwoord wijzigen mislukt"))
                
            }
        }
        task.resume()
    }
}
