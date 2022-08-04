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
    
    @Published var errorMessage = ""
    @Published var showingError = false
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signup(name: String, email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError.toggle()
                return
            }
            
            guard let user = result?.user else { return }
            self.user = user
            
            let data = ["name": name, "email": email, "username": username, "uid": user.uid]
            
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data)
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError.toggle()
                return
            }
            
            guard let user = result?.user else { return }
            self.user = user
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
