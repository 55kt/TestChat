//
//  NewMessageView.swift
//  TestChat
//
//  Created by Vlad on 24/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    
    //MARK: - Properties
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var vm = NewMessageViewModel()
    let didSelectedNewUser: (ChatUser) -> ()
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(vm.errorMessage)
                ForEach(vm.users) {user in
                    
                    // User Select Button 
                    Button {
                        //action
                    } label: {
                        HStack {
                            VStack {
                                NavigationLink {
                                    ChatLogView(chatUser: ChatUser(data: ["nickname": user.nickname]))
                                } label: {
                                    HStack(spacing: 16) {
                                        // User image
                                        WebImage(url: URL(string: user.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                            .cornerRadius(60)
                                            .overlay(RoundedRectangle(cornerRadius: 60)
                                                .stroke(.gray.opacity(0.5))
                                            )
                                            .shadow(radius: 5)
                                        //User Nickname
                                        VStack(alignment: .leading) {
                                            Text(user.nickname)
                                                .font(.system(size: 21, weight: .regular))
                                                .foregroundStyle(Color(.label))
                                        }
                                        Spacer()
                                    }
                                    Divider()
                                        .padding(.vertical, 8)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            // Nav Bar & Cancel button
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                        
                    }
                }
            }
        }
    }
}
//MARK: - Preview
#Preview {
    NewMessageView(didSelectedNewUser: { user in print(user.email) })
}



