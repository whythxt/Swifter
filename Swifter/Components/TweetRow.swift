//
//  TweetRow.swift
//  Swifter
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct TweetRow: View {
    @ObservedObject var vm: TweetRowViewModel
    
    init(tweet: Tweet) {
        self.vm = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = vm.tweet.user {
                HStack(alignment: .top, spacing: 10) {
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        AsyncImage(url: URL(string: user.imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            Circle()
                        }
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Text(user.name)
                                .font(.headline)
                            
                            Text("@\(user.username)")
                                .foregroundColor(.secondary)
                                .font(.callout)
                            
                            Text("· 4h")
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                        
                        Text(vm.tweet.caption)
                            .multilineTextAlignment(.leading)
                        
                        HStack(spacing: 50) {
                            Button {
                                
                            } label: {
                                Image(systemName: "bubble.left")
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.2.squarepath")
                            }
                            
                            Button {
                                vm.liked ? vm.unlike() : vm.like()
                            } label: {
                                Image(systemName: vm.liked ? "heart.fill" : "heart")
                                    .foregroundColor(vm.liked ? .orange : .gray)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        .padding(.vertical, 5)
                        .foregroundColor(.secondary)
                    }
                }
            }
            
            Divider()
                .padding(.vertical, 3)
        }
        .padding(.leading)
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRow(tweet: Tweet.example)
    }
}
