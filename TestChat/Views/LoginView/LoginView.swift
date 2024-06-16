//
//  LoginView.swift
//  TestChat
//
//  Created by Vlad on 15/6/24.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct LoginView: View {
    
    //MARK: - Properties
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var image: UIImage?
    @State var shouldShowImagePicker = false
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    
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
                            shouldShowImagePicker.toggle()
                        } label: {
                            
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 64))
                                        .padding()
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.5)
                            )
                            
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
                    Text(self.firebaseManager.loginStatusMessage)
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
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
            ImagePicker(image: $image)
        })
    }
    
    //MARK: - Methods
    
    
    
    // Auth Function
    private func handleAction() {
        if isLoginMode {
            firebaseManager.loginUser(email: email, password: password)
        } else {
            firebaseManager.createNewAccount(email: email, password: password, image: image)
        }
    }
}
        
        //MARK: - Preview
        #Preview {
            LoginView()
        }
