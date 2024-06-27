//
//  ChatLogView.swift
//  TestChat
//
//  Created by Vlad on 25/6/24.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationTitle(chatUser?.nickname ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var messagesView: some View {
        VStack {
                ScrollView {
                    ForEach(vm.chatMessages) { message in
                        VStack {
                            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                                HStack {
                                    Spacer()
                                    HStack {
                                        Text(message.text)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                                }
                            } else {
                                HStack {
                                    HStack {
                                        Text(message.text)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(8)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                    }
                    
                    HStack{ Spacer() }
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private struct DescriptionPlaceholder: View {
        var body: some View {
            HStack {
                Text("Description")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 17))
                    .padding(.leading, 5)
                    .padding(.top, -4)
                Spacer()
            }
        }
    }
}

//MARK: - Preview
#Preview {
    NavigationStack { // This Stack needed for navigationTitle preview
        ChatLogView(chatUser: ChatUser(data: ["uid": "5uyUUU7AOIT52pPboIXlDLSyYRV2", "nickname": "Dyadya Dima"]))
    }
}
