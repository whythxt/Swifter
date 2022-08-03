//
//  SearchBar.swift
//  TwitterClone
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search Twitter", text: $text)
                .accentColor(.orange)
                .multilineTextAlignment(isEditing ? .leading : .center)
                .padding(5)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .frame(width: isEditing ? 300 : 250)
                .onTapGesture {
                    isEditing = true
                }
            
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                    
                } label: {
                    Text("Cancel")
                }
                .foregroundColor(.primary)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
