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
    @State var chatMessage = ""
    
    //MARK: - Body
    var body: some View {
        VStack {
            
            // Central message arrea
            ScrollView {
                ForEach(0..<10) { num in
                    HStack {
                        Spacer()
                        HStack {
                            Text("Fake Message for now ! Hello World")
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 7))
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                }
                HStack{ Spacer() }
            }
            .background(Color(.init(white: 0.90, alpha: 1)))
            
            // Lower message send nav bar
            HStack(spacing: 16) {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(.darkGray))
//                TextEditor(text: $chatMessage)
                TextField("Description", text: $chatMessage)
                Button {
                    // action
                } label: {
                    Text("Send")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 7))
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            
        }
        
        // Navigation Bar
        .navigationTitle(chatUser?.nickname ?? "No Nickname")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Preview
#Preview {
    NavigationStack { // This Stack needed for navigationTitle preview 
        ChatLogView(chatUser: ChatUser(data: ["uid": "5uyUUU7AOIT52pPboIXlDLSyYRV2", "nickname": "Dyadya Dima"]))
    }
}
