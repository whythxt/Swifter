//
//  User.swift
//  Swifter
//
//  Created by Yurii on 07.08.2022.
//

import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    let name: String
    let email: String
    let username: String
    let imageURL: String
    
    static let example = User(name: "Yurii", email: "123@gmail.com", username: "whythat", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg")
}
