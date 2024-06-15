//
//  LoginView.swift
//  TestChat
//
//  Created by Vlad on 15/6/24.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - Properties
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Picker(selection: $isLoginMode, label: Text("Picker Here")) {
                        Text("Log In")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    
                    if !isLoginMode {
                        Button {
                            //
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.none)
                        
                        PasswordField(password: $password)
                    }
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    
                    CustomButton(buttonTitle: isLoginMode ? "Log In" : "Create Account") {}
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Image("sky_background_blur")
                .blur(radius: 3)
                .ignoresSafeArea())
        }
    }
}

//MARK: - Preview
#Preview {
    LoginView()
}
