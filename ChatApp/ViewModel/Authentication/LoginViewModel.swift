//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import Foundation

// Login Form Validation
protocol AuthenticationProtocol {
    var formIsValid: Bool {get}
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
