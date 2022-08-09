//
//  SearchView.swift
//  Swifter
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm = SearchViewModel()
    
    @Binding var showingMenu: Bool
    
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
                SearchBar(text: $vm.text)
            )
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.searchUsers, id: \.id) { user in
                        SearchRow(user: user)
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
