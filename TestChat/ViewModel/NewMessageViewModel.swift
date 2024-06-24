//
//  NewMessageViewModel.swift
//  TestChat
//
//  Created by Vlad on 24/6/24.
//

import SwiftUI
import SDWebImage

class NewMessageViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    //MARK: - Initializer
    init() {
        fetchAllUsers()
    }
    
    // Fetch Users in list Function
    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = ChatUser(data: data)
                    if user.uid !=
                        FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
            }
    }
}

//MARK: - Preview
#Preview {
    NewMessageView()
}
