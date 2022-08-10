//
//  Tweet.swift
//  Swifter
//
//  Created by Yurii on 09.08.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Tweet: Codable, Identifiable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var isLiked: Bool? = false
    
    static let example = Tweet(caption: "test tweet", timestamp: Timestamp(date: Date.now), uid: "uid", likes: 0)
}
