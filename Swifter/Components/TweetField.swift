//
//  TweetField.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct TweetField: View {
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text("What's happening?")
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
            }
            
            TextEditor(text: $text)
                .accentColor(.orange)
                .padding(4)
        }
    }
}

struct TweetField_Previews: PreviewProvider {
    static var previews: some View {
        TweetField(text: .constant(""))
    }
}
