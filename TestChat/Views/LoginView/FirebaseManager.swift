//
//  FirebaseManager.swift
//  TestChat
//
//  Created by Vlad on 16/6/24.
//

import Firebase
import FirebaseStorage
import SwiftUI

class FirebaseManager: ObservableObject {
    
    static let shared = FirebaseManager()
    
    
    // Initializer
    init() {
        FirebaseApp.configure()
    }
    
    // Status Message
    @Published var loginStatusMessage = ""
    
    // Log In Function
     func loginUser(email: String, password: String) {
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
     func createNewAccount(email: String, password: String, image: UIImage?) {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to create a user", err)
                self.loginStatusMessage = "Failed to create user \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")") // Console Preview
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage(image: image)
        }
    }
    
    // Image Saving in Fire Base Storage
     func persistImageToStorage(image: UIImage?) {
        guard let uid = Auth.auth().currentUser?.uid
            else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            // Action Print Massage
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrive downloadURL: \(err)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
            }
        }
    }
}
