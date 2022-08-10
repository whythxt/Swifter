//
//  ProfileViewModel.swift
//  Swifter
//
//  Created by Yurii on 10.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    let user: User
    
    private let service = TweetService()
    private let uService = UserService()
    
    init(user: User) {
        self.user = user
        self.fetch()
        self.fetchLiked()
    }
    
    func tweets(filter: Filter) -> [Tweet] {
        switch filter {
        case .tweets:
            return tweets
        case .replies:
            return tweets
        case .likes:
            return likedTweets
        }
    }
    
    func fetch() {
        guard let uid = user.id else { return}
        
        service.fetchTweets(for: uid) { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    func fetchLiked() {
        guard let uid = user.id else { return }
        
        service.fetchLikes(for: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                self.uService.fetchUser(uid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
    }
}
