//
//  ChatLogViewModel.swift
//  TestChat
//
//  Created by Vlad on 26/6/24.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    
    //MARK: - Properties
    let chatUser: ChatUser?
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    //MARK: - Initializer
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    //MARK: - Methods
    
    // Sending message function & collect messages in firestore
    func handleSend() {
        print(chatText)
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid
        else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore.collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = ["fromId": fromId, "toId": toId, "text": self.chatText, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Successfully saved current user sending message")
            self.chatText = ""
        }
        
        let recipientMessageDocument = FirebaseManager.shared.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Recipient saved message as well")
        }
    }
}
