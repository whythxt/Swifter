//
//  AuthViewModel.swift
//  Swifter
//
//  Created by Yurii on 04.08.2022.
//

import Firebase
import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signup(name: String, email: String, password: String, username: String) {
        
    }
    
    func login(email: String, password: String) {
        
    }
}
