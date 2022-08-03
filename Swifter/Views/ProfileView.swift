//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

enum Filter: Int, CaseIterable {
    case tweets, replies, likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedFilter: Filter = .tweets
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                Color.orange
                    .ignoresSafeArea()
                
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    
                    Circle()
                        .frame(width: 70, height: 70)
                        .offset(x: 10, y: 35)
                }
            }
            .frame(height: 90)
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Edit profile")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 110, height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray))
                        .padding(.horizontal)
                }
            }
            .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("whythat")
                    .font(.title2)
                    .bold()
                
                Text("@whythxt")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("iOS developer")
                    .padding(.vertical)
                
                HStack(spacing: 10) {
                    HStack(spacing: 3) {
                        Text("10")
                            .bold()
                        
                        Text("Following")
                            .foregroundColor(.secondary)
                    }
                    .font(.callout)
                    
                    HStack(spacing: 3) {
                        Text("0")
                            .bold()
                        
                        Text("Followers")
                            .foregroundColor(.secondary)
                    }
                    .font(.callout)
                }
            }
            .padding(.horizontal)
            
            HStack {
                ForEach(Filter.allCases, id: \.rawValue) { filter in
                    VStack {
                        Text(filter.title)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                            .foregroundColor(selectedFilter == filter ? .primary : .secondary)
                        
                        if selectedFilter == filter {
                            Capsule()
                                .foregroundColor(.orange)
                                .frame(height: 3)
                                .padding(.horizontal, 5)
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 3)
                                .padding(.horizontal, 5)
                        }
                    }
                    .onTapGesture {
                        selectedFilter = filter
                    }
                }
            }
            .padding(.vertical, 5)
            .overlay(Divider().offset(x: 0, y: 16))
            
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id: \.self) {_ in 
                        TweetRowView()
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
