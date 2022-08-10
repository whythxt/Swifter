//
//  TweetRowViewModel.swift
//  Swifter
//
//  Created by Yurii on 10.08.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    private let service = TweetService()
    
    var liked: Bool {
        tweet.isLiked ?? false ? true : false
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        check()
    }
    
    func like() {
        service.like(tweet) {
            self.tweet.isLiked = true
        }
    }
    
    func unlike() {
        service.unlike(tweet) {
            self.tweet.isLiked = false
        }
    }
    
    func check() {
        service.checkLike(tweet) { isLiked in
            if isLiked {
                self.tweet.isLiked = true
            }
        }
    }
}
