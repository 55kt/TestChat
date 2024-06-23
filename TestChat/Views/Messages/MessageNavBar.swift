//
//  MessageNavBar.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageNavBar: View {
    
    //MARK: - Properties
    @EnvironmentObject var mmvm: MainMessagesViewModel
    @State var shouldShowLogOutOptions = false
    
    
    //MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            
            // User image
            WebImage(url: URL(string: mmvm.chatUser?.profileImageUrl ?? "person.fill"))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(60)
                .overlay(RoundedRectangle(cornerRadius: 60)
                    .stroke(.gray.opacity(0.5))
                )
                .shadow(radius: 5)
            
            // Username
            VStack(alignment: .leading, spacing: 4) {
                Text(mmvm.chatUser?.nickname ?? "")
                    .font(.system(size: 24, weight: .bold))
                HStack {
                    // Online status
                    Circle()
                        .foregroundStyle(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.lightGray))
                }
            }
            
            // Log out nav bar button image
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color(.label))
            }
        }
        .padding()
        
        // Log out banner functionality
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message:
                    Text("What do you want to do ?"), buttons: [
                        .destructive(Text("Sign Out"), action: {
                            print("handle sign out")
                            mmvm.handleSignOut()
                        }),
                        .cancel()
                    ])
        }
        .fullScreenCover(isPresented: $mmvm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            LoginView(didCompleteLoginProcess: {
                self.mmvm.isUserCurrentlyLoggedOut = false
                self.mmvm.fetchCurrentUser()
            })
        }
    }
}

//MARK: - Preview
#Preview {
    MessageNavBar()
}
