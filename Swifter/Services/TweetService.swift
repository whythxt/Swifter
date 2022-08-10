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
    
    func like(_ tweet: Tweet, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        
        let userLikes = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore()
            .collection("tweets")
            .document(tweetID)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikes.document(tweetID).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unlike(_ tweet: Tweet, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikes = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore()
            .collection("tweets")
            .document(tweetID)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikes.document(tweetID).delete { _ in
                    completion()
                }
            }
    }
    
    func checkLike(_ tweet: Tweet, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetID)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // Fetch liked tweets for ProfileView
    
    func fetchLikes(for uid: String, completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore()
                        .collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
    }
}
