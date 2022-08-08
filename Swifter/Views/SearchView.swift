//
//  SearchView.swift
//  Swifter
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct SearchView: View {
    @Binding var showingMenu: Bool
    @State private var text = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                HStack {
                    NavBarPic(showingMenu: $showingMenu)
                    
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
                        SearchRow()
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
        SearchView(showingMenu: .constant(false))
    }
}
