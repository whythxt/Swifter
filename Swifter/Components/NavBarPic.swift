//
//  NavBarPic.swift
//  Swifter
//
//  Created by Yurii on 08.08.2022.
//

import SwiftUI

struct NavBarPic: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @Binding var showingMenu: Bool
    
    var body: some View {
        if let user = vm.currentUser {
            Button {
                withAnimation { showingMenu.toggle() }
            } label: {
                AsyncImage(url: URL(string: user.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBarPic(showingMenu: .constant(false))
    }
}
