//
//  NotificationsView.swift
//  Swifter
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct NotificationsView: View {
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
                Text("Notifications")
                    .bold()
            )
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(showingMenu: .constant(false))
    }
}
