//
//  TabButton.swift
//  Swifter
//
//  Created by Yurii on 28.07.2022.
//

import SwiftUI

struct SideButton: View {
    @EnvironmentObject var vm: AuthViewModel
    
    let title: String
    let image: String
    
    var body: some View {
        if let user = vm.currentUser {
            NavigationLink {
                switch title {
                case "Profile": ProfileView(user: user)
                default: Text(title)
                }
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: image)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                    
                    Text(title)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        SideButton(title: "Profile", image: "person")
            .environmentObject(AuthViewModel())
    }
}
