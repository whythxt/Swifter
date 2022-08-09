//
//  NewTweetViewModel.swift
//  Swifter
//
//  Created by Yurii on 09.08.2022.
//

import Foundation

class NewTweetViewModel: ObservableObject {
    @Published var text = ""
    
    let service = TweetService()
    
    var disabled: Bool {
        text.trimmingCharacters(in: .whitespaces).isEmpty ? true : false
    }
    
    func tweet(caption: String) {
        service.tweet(caption: caption)
    }
}
