//
//  NewTweetView.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct NewTweetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var tm = NewTweetViewModel()
    @EnvironmentObject var vm: AuthViewModel
    
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
                    tm.tweet(caption: tm.text)
                    dismiss()
                } label: {
                    Text("Tweet")
                        .font(.callout)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(tm.disabled ? .gray : .orange)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(tm.disabled)

            }
            
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: vm.currentUser?.imageURL ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .scaledToFill()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
                
                TweetField(text: $tm.text)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
            .environmentObject(AuthViewModel())
    }
}
