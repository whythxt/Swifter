//
//  UserService.swift
//  Swifter
//
//  Created by Yurii on 07.08.2022.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct UserService {
    // Fetch current user
    
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    // Fetch all users for SearchView
    
    func fetchUserList(completion: @escaping ([User]) -> Void) {
        Firestore.firestore()
            .collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let users = documents.compactMap { try? $0.data(as: User.self) }
                completion(users)
            }
    }
}
