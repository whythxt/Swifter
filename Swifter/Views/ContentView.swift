//
//  ContentView.swift
//  Swifter
//
//  Created by Yurii on 28.07.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var showingMenu = false
    @State private var showingSheet = false
    @State private var currentTab = "house"
    
    @State private var offset: CGFloat = 0
    @State private var lastStoredOffset: CGFloat = 0
    
    @GestureState private var gestureOffset: CGFloat = 0
    
    var body: some View {
        let sideBarWidth = getRect().width - 90
        
        if vm.user == nil {
            SignUpView()
        } else {
            NavigationView {
                HStack(spacing: 0) {
                    SideMenu(showingMenu: $showingMenu)
                    
                    VStack(spacing: 0) {
                        TabView(selection: $currentTab) {
                            HomeView(showingMenu: $showingMenu, showingSheet: $showingSheet)
                                .navigationBarHidden(true)
                                .tag("house")
                            
                            SearchView(showingMenu: $showingMenu)
                                .navigationBarHidden(true)
                                .tag("magnifyingglass")
                            
                            SpacesView(showingMenu: $showingMenu)
                                .navigationBarHidden(true)
                                .tag("mic")
                            
                            NotificationsView(showingMenu: $showingMenu)
                                .navigationBarHidden(true)
                                .tag("bell")
                            
                            MessagesView(showingMenu: $showingMenu)
                                .navigationBarHidden(true)
                                .tag("envelope")
                        }
                        
                        VStack {
                            Divider()
                            
                            HStack(spacing: 0) {
                                TButton(image: "house")
                                TButton(image: "magnifyingglass")
                                TButton(image: "mic")
                                TButton(image: "bell")
                                TButton(image: "envelope")
                            }
                        }
                    }
                    .frame(width: getRect().width)
                    .overlay(
                        Rectangle()
                            .fill(Color.primary.opacity(Double((offset / sideBarWidth) / 5)))
                            .ignoresSafeArea(.container, edges: .vertical)
                            .onTapGesture {
                                showingMenu.toggle()
                            }
                    )
                }
                .frame(width: getRect().width + sideBarWidth)
                .offset(x: -sideBarWidth / 2)
                .offset(x: offset > 0 ? offset : 0)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded(onEnd)
                )
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(isPresented: $showingSheet) {
                    NewTweetView()
                }
            }
            .animation(.easeOut, value: offset == 0)
            .onChange(of: showingMenu) { newValue in
                if showingMenu && offset == 0 {
                    offset = sideBarWidth
                    lastStoredOffset = offset
                }
                
                if !showingMenu && offset == sideBarWidth {
                    offset = 0
                    lastStoredOffset = 0
                }
            }
            .onChange(of: gestureOffset) { newValue in
                onChange()
            }
        }
        
    }
    
    func onChange() {
        let sideBarWidth = getRect().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnd(value: DragGesture.Value) {
        let sideBarWidth = getRect().width - 90
        let translation = value.translation.width
        
        withAnimation {
            if translation > 0 {
                if translation > (sideBarWidth / 2) {
                    offset = sideBarWidth
                    showingMenu = true
                } else {
                    if offset == sideBarWidth {
                        return
                    }
                    
                    offset = 0
                    showingMenu = false
                }
            } else {
                if -translation > (sideBarWidth / 2) {
                    offset = 0
                    showingMenu = false
                } else {
                    if offset == 0 || !showingMenu {
                        return
                    }
                    
                    offset = sideBarWidth
                    showingMenu = true
                }
            }
        }
        
        lastStoredOffset = offset
    }
    
    @ViewBuilder func TButton(image: String) -> some View {
        Button {
            withAnimation { currentTab = image }
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
