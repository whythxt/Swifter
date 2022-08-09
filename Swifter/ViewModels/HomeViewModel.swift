//
//  HomeViewModel.swift
//  Swifter
//
//  Created by Yurii on 09.08.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    let service = TweetService()
    let uService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetch { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                self.uService.fetchUser(uid: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
