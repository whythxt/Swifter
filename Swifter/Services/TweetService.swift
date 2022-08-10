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
    
    // Fetch tweets for HomeView
    
    func fetch(completion: @escaping ([Tweet]) -> Void) {
        Firestore.firestore()
            .collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets)
            }
    }
    
    // Fetch tweets for ProfileView
    
    func fetchTweets(for uid: String, completion: @escaping ([Tweet]) -> Void) {
        Firestore.firestore()
            .collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() } ))
            }
    }
}
