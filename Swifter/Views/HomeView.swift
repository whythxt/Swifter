//
//  HomeView.swift
//  Swifter
//
//  Created by Yurii on 28.07.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    
    @Binding var showingMenu: Bool
    @Binding var showingSheet: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    NavBarPic(showingMenu: $showingMenu)
                    
                    Spacer()
                    
                    NavigationLink {
                        Text("Timeline")
                            .navigationTitle("Timeline")
                    } label: {
                        Image(systemName: "sparkles")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                Divider()
            }
            .overlay(
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.orange)
            )
            
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.tweets) { tweet in
                            TweetRow(tweet: tweet)
                        }
                    }
                }
                
                NewTweetButton(showingSheet: $showingSheet)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
