//
//  SpacesView.swift
//  Swifter
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct SpacesView: View {
    @Binding var showingMenu: Bool
    
    var body: some View {
        VStack {
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
                Text("Spaces")
                    .bold()
            )
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView(showingMenu: .constant(false))
    }
}
