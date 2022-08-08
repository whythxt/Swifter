//
//  AuthViewModel.swift
//  Swifter
//
//  Created by Yurii on 04.08.2022.
//

import Firebase
import FirebaseStorage
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    @Published var showingLogin = false
    
    @Published var errorMessage = ""
    @Published var showingError = false
    
    @Published var showingImagePicker = false
    @Published var image: UIImage?
    
    private let service = UserService()
    
    init() {
        self.user = Auth.auth().currentUser
        self.fetchUser()
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
            self.persistImageToStorage()
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
            self.clearInput()
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
    
    private func persistImageToStorage() {
        guard let uid = user?.uid else { return }
        
        let ref = Storage.storage().reference(withPath: uid)
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }

        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let url = url else { return }
                self.storeUserInformation(imageURL: url)
            }
        }
    }
    
    private func storeUserInformation(imageURL: URL) {
        guard let uid = user?.uid else { return }
        
        let data = ["name": name, "email": email, "username": username, "uid": uid, "imageURL": imageURL.absoluteString]
        
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    func fetchUser() {
        guard let uid = self.user?.uid else { return }
        
        service.fetchUser(uid: uid) { user in
            self.currentUser = user
        }
    }
    
    func clearInput() {
        name = ""
        email = ""
        password = ""
        username = ""
        image = nil
    }
}
