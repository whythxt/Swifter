//
//  NewTweetView.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct NewTweetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var text = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Tweet")
                        .font(.callout)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.orange)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

            }
            
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 30, height: 40)
                
                TweetField(text: $text)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
