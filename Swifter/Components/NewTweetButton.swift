//
//  NewTweetButton.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct NewTweetButton: View {
    @Binding var showingSheet: Bool
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .padding()
        }
        .background(.orange)
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding(.horizontal)
    }
}

struct NewTweetButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetButton(showingSheet: .constant(false))
    }
}
