//
//  SearchRow.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct SearchRow: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Circle()
            }
            .scaledToFill()
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            
            NavigationLink {
                ProfileView(user: user)
            } label: {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    
                    Text("@\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .foregroundColor(.primary)
        }
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(user: User.example)
    }
}
