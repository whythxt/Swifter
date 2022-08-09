//
//  SearchViewModel.swift
//  Swifter
//
//  Created by Yurii on 09.08.2022.
//

import Foundation


class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var text = ""
    
    var searchUsers: [User] {
        if text.isEmpty {
            return users
        } else {
            return users.filter { $0.username.lowercased().contains(text.lowercased()) || $0.name.lowercased().contains(text.lowercased()) }
        }
    }
    
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUserList { users in
            self.users = users
        }
    }
}
