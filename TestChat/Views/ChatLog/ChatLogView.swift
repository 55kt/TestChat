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
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                HStack {
                    Text("Fake Message for now ! Hello World")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.blue)
                .clipShape(.rect(cornerRadius: 7))
            }
        }.navigationTitle(chatUser?.nickname ?? "No Nickname")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Preview
#Preview {
    NavigationStack { // This Stack needed for navigationTitle preview 
        ChatLogView(chatUser: ChatUser(data: ["uid": "5uyUUU7AOIT52pPboIXlDLSyYRV2", "nickname": "Dyadya Dima"]))
    }
}
