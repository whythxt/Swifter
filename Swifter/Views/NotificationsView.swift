//
//  NotificationsView.swift
//  TwitterClone
//
//  Created by Yurii on 02.08.2022.
//

import SwiftUI

struct NotificationsView: View {
    @State private var showingMenu = false
    
    var body: some View {
        VStack {
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
        NotificationsView()
    }
}
