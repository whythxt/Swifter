//
//  TweetService.swift
//  Swifter
//
//  Created by Yurii on 09.08.2022.
//

import Firebase
import Foundation

struct TweetService {
    func tweet(caption: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid, "caption": caption, "likes": 0, "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore()
            .collection("tweets")
            .document()
            .setData(data)
    }
    
    func fetch(completion: @escaping ([Tweet]) -> Void) {
        Firestore.firestore()
            .collection("tweets")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets)
            }
    }
}
