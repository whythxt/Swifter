//
//  SwifterApp.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import Firebase
import SwiftUI

@main
struct SwifterApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SignUpView()
        }
    }
}
