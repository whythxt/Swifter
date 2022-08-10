//
//  ProfileViewModel.swift
//  Swifter
//
//  Created by Yurii on 10.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    let user: User
    private let service = TweetService()
    
    init(user: User) {
        self.user = user
        self.fetch()
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
}
