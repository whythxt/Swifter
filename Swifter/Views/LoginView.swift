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
    
    var disabled: Bool {
        vm.email.trimmingCharacters(in: .whitespaces).isEmpty || vm.password.trimmingCharacters(in: .whitespaces).isEmpty ? true : false
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
                TextField("Email", text: $vm.email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                Divider()
                
                SecureField("Password", text: $vm.password)
                    .textInputAutocapitalization(.never)
                Divider()
            }
            .padding(.horizontal, 30)
            
            Button {
                vm.login(email: vm.email, password: vm.password)
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
        .alert(vm.errorMessage, isPresented: $vm.showingError) {
            Button("OK", role: .cancel) { vm.clearInput() }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
