//
//  LoginView.swift
//  TestChat
//
//  Created by Vlad on 15/6/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    //MARK: - Properties
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    //MARK: - Initializer
    init() {
        FirebaseApp.configure()
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Nav Bar Picker Buttons
                    Picker(selection: $isLoginMode, label: Text("Picker Here")) {
                        Text("Log In")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Icon Add Button
                    if !isLoginMode {
                        Button {
                            //
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                        }
                    }
                    
                    // Fields Arrea
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.none)
                            .foregroundStyle(.primary)
                        
                        PasswordField(password: $password)
                    }
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    
                    // Auth Button
                    CustomButton(buttonTitle: isLoginMode ? "Log In" : "Create Account") {
                        handleAction()
                    }
                    Text(self.loginStatusMessage)
                        .foregroundStyle(.red)
                }
                .padding()
            }
            // Nav Bar Text
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Image("sky_background_blur")
                .blur(radius: 3)
                .ignoresSafeArea())
        }
    }
    
    //MARK: - Methods
    
    // Auth Function
    private func handleAction() {
        if isLoginMode {
            print("is login action ")
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    // Status Message
    @State var loginStatusMessage = ""
    
    // Log In Function
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to login user", err)
                self.loginStatusMessage = "Failed to login user \(err)"
                return
            }
            print("Successfully Logged In as user: \(result?.user.uid ?? "")") // Console Preview
            
            self.loginStatusMessage = "Successfully Logged In as user: \(result?.user.uid ?? "")"
        }
    }
        
    // Register Function
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to create a user", err)
                self.loginStatusMessage = "Failed to create user \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")") // Console Preview
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
}

//MARK: - Preview
#Preview {
    LoginView()
}
