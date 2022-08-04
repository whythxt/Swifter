//
//  LoginView.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var disabled: Bool {
        email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty ? true : false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.orange)
                
                Spacer()
                
                Button("Cancel") { }.opacity(0.0)
                
            }
            .padding(.horizontal, 5)
            
            Spacer()
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                
                Divider()
                
                SecureField("Password", text: $password)
                Divider()
            }
            .padding(.horizontal, 30)
            
            Button {
                vm.login(email: email, password: password)
                clearInput()
            } label: {
                Text("Log in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(disabled ? .gray : .black)
                    .clipShape(Capsule())
                    .padding()
            }
            .disabled(disabled)
        
            Spacer()
        }
    }
    
    func clearInput() {
        email = ""
        password = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
