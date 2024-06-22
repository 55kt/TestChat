//
//  FirebaseManager.swift
//  TestChat
//
//  Created by Vlad on 21/6/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager:NSObject, ObservableObject {
    
    //MARK: - Properties
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    
    //MARK: - Initializer
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        self.user = User.init(email: "", password: "", nickname: "")
        
        super.init()
    }
}
