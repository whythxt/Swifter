//
//  SignUpView.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    
    @State private var showingLogin = false
    
    var disabled: Bool {
        name.trimmingCharacters(in: .whitespaces).isEmpty || email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || username.trimmingCharacters(in: .whitespaces).isEmpty ? true : false
    }
    
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.orange)
            
            Spacer()
            
            VStack(spacing: 20) {
                TextField("Name", text: $name)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.words)
                Divider()
                
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                Divider()
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                Divider()
                
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                Divider()
            }
            .padding(.horizontal, 30)
            
            Button {
                vm.signup(name: name, email: email, password: password, username: username)
                clearInput()
            } label: {
                Text("Create account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(disabled ? .gray : .black)
                    .clipShape(Capsule())
                    .padding()
            }
            .disabled(disabled)
            
            Spacer()
            
            HStack {
                Text("Have an account already?")
                    .foregroundColor(.secondary)
                
                Button("Log in") {
                    showingLogin.toggle()
                }
                .foregroundColor(.orange)
            }
            .font(.subheadline)
        }
        .alert(vm.errorMessage, isPresented: $vm.showingError) {
            Button("OK", role: .cancel) { }
        }
        .fullScreenCover(isPresented: $showingLogin) {
            LoginView()
        }
    }
    
    func clearInput() {
        name = ""
        email = ""
        password = ""
        username = ""
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
