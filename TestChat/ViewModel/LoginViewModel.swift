//
//  LoginViewModel.swift
//  TestChat
//
//  Created by Vlad on 22/6/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var nickname = ""
    @Published var image: UIImage?
    @Published var isLoginMode = true
    @Published var loginStatusMessage = ""
    
    private var firebaseManager = FirebaseManager.shared
    
    init(fbm: FirebaseManager, user: User, isLoginMode: Bool = false, shouldShowImagePicker: Bool = false, image: UIImage? = nil, loginStatusMessage: String = "", currentUser: User? = nil) {
        self.fbm = fbm
        self.user = user
        self.isLoginMode = isLoginMode
        self.shouldShowImagePicker = shouldShowImagePicker
        self.image = image
        self.loginStatusMessage = loginStatusMessage
        self.currentUser = currentUser
    }
    
    
    
    var user: User
    
    @Published var isLoginMode = false
    @Published var shouldShowImagePicker = false
    @Published var image: UIImage?
    @Published var loginStatusMessage = ""
    @Published var currentUser: User?
    
    static let shared = FirebaseManager()
    
    // Login Function
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
//            self.didCompletedLoginProcess()
        }
    }
    
    // Register Function
    func createNewAccount(user: User, image: UIImage?) {
        auth.createUser(withEmail: user.email, password: user.password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.persistImageToStorage(user: user, image: image)
        }
    }
    
    // Image Saving in Firebase Storage
    func persistImageToStorage(user: User, image: UIImage?) {
        guard let uid = auth.currentUser?.uid else { return }
        let ref = storage.reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                guard let url = url else { return }
                self.storeUserInformation(user: user, imageProfileUrl: url)
            }
        }
    }
}

#Preview {
    LoginViewModel()
}
