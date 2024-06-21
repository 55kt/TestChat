//
//  MainMessageViewModel.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import SwiftUI

struct ChatUser {
    let uid, email, nickname, profileImageUrl: String
}

class MainMessageViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    //MARK: - Initializer
    init() {
        fetchCurrentUser()
    }
    
    // Fetch user data function
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        self.errorMessage = "\(uid)"
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user \(error)"
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                // Getting user data
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profileImageIUrl = data["profileImageUrl"] as? String ?? ""
                let nickname = data["nickname"] as? String ?? ""
                self.chatUser = ChatUser(uid: uid, email: email, nickname: nickname, profileImageUrl: profileImageIUrl)
            }
    }
}

//MARK: - Preview
#Preview {
    MainMessageView()
        .environmentObject(MainMessageViewModel())
}
