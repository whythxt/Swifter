//
//  SearchView.swift
//  TwitterClone
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var showingMenu = false
    @State private var text = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        withAnimation { showingMenu.toggle() }
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                Divider()
            }
            .overlay(
                SearchBar(text: $text)
            )
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(1...10, id: \.self) { _ in
                        SearchRowView()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
