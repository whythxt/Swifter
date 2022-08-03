//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("whythat")
                            .font(.headline)
                        
                        Text("@whythxt")
                            .foregroundColor(.secondary)
                            .font(.callout)
                        
                        Text("· 4h")
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                    
                    Text("I'm dog backwards")
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
                            
                        } label: {
                            Image(systemName: "heart")
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
    
            Divider()
                .padding(.vertical, 3)
        }
        .padding(.leading)
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView()
    }
}
