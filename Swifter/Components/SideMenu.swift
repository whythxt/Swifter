//
//  SideView.swift
//  Swifter
//
//  Created by Yurii on 28.07.2022.
//

import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @Binding var showingMenu: Bool
    
    var body: some View {
        if let user = vm.currentUser {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: user.imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.fill")
                    }
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                    
                    Text(user.name)
                        .font(.title2.bold())
                    
                    Text("@\(user.username)")
                        .font(.callout)
                    
                    HStack(spacing: 12) {
                        Button {
                            
                        } label: {
                            Label {
                                Text("Following")
                            } icon: {
                                Text("10")
                                    .bold()
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            Label {
                                Text("Followers")
                            } icon: {
                                Text("0")
                                    .bold()
                            }
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.top)
                }
                .padding(.horizontal)
                .padding(.leading)
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 45) {
                            SideButton(title: "Profile", image: "person")
                            SideButton(title: "Lists", image: "list.bullet.rectangle.portrait")
                            SideButton(title: "Topics", image: "message")
                            SideButton(title: "Bookmarks", image: "bookmark")
                            SideButton(title: "Moments", image: "bolt")
                            SideButton(title: "Purchases", image: "cart")
                            SideButton(title: "Monetization", image: "banknote")
                        }
                        .padding()
                        .padding(.leading)
                        .padding(.top, 10)
                        
                        Divider()
                        
                        SideButton(title: "Swifter for Professionals", image: "airplane")
                            .padding()
                            .padding(.leading)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 30) {
                            Button("Settings and privacy") {
                                
                            }
                            
                            Button("Log out") {
                                vm.logOut()
                            }
                            .foregroundColor(.red)
                        }
                        .padding()
                        .padding(.leading)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                    }
                }
                
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "lightbulb")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "qrcode")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding([.horizontal, .top], 15)
                    .foregroundColor(.primary)
                }
            }
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: getRect().width - 90)
            .frame(maxHeight: .infinity)
            .background(Color.primary.opacity(0.04).ignoresSafeArea(.container, edges: .vertical))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(showingMenu: .constant(true))
            .environmentObject(AuthViewModel())
    }
}
