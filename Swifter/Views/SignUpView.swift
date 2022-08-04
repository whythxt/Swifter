//
//  SignUpView.swift
//  Swifter
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    var disabled: Bool {
        vm.name.trimmingCharacters(in: .whitespaces).isEmpty || vm.email.trimmingCharacters(in: .whitespaces).isEmpty || vm.password.trimmingCharacters(in: .whitespaces).isEmpty || vm.username.trimmingCharacters(in: .whitespaces).isEmpty || vm.image == nil ? true : false
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
                Button {
                    vm.showingImagePicker.toggle()
                } label: {
                    VStack {
                        if let image = vm.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(64)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                                .foregroundColor(Color(.label))
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color(.label)))
                
                TextField("Name", text: $vm.name)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.words)
                Divider()
                
                TextField("Email", text: $vm.email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                Divider()
                
                SecureField("Password", text: $vm.password)
                    .textInputAutocapitalization(.never)
                Divider()
                
                TextField("Username", text: $vm.username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                Divider()
            }
            .padding(.horizontal, 30)
            
            Button {
                vm.signup(name: vm.name, email: vm.email, password: vm.password, username: vm.username)
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
                    vm.showingLogin.toggle()
                }
                .foregroundColor(.orange)
            }
            .font(.subheadline)
        }
        .onAppear {
            vm.clearInput()
        }
        .sheet(isPresented: $vm.showingImagePicker) {
            ImagePicker(image: $vm.image)
        }
        .alert(vm.errorMessage, isPresented: $vm.showingError) {
            Button("OK", role: .cancel) { vm.clearInput() }
        }
        .fullScreenCover(isPresented: $vm.showingLogin) {
            LoginView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}
