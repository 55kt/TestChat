//
//  ChatLogView.swift
//  TestChat
//
//  Created by Vlad on 25/6/24.
//

import SwiftUI

struct ChatLogView: View {
    
    //MARK: - Properties
    let chatUser: ChatUser?
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                Text("Fake Message")
            }
        }.navigationTitle(chatUser?.nickname ?? "No Nickname")
    }
}

#Preview {
    NavigationStack { // This Stack needed for navigationTitle preview 
        ChatLogView(chatUser: ChatUser(data: ["uid": "123", "email": "test@example.com", "nickname": "Test User", "profileImageUrl": ""]))
    }
}
