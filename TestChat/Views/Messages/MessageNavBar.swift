//
//  MessageNavBar.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import SwiftUI

struct MessageNavBar: View {
    
    //MARK: - Properties
    @State var logOutOption = false
    
    //MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            // User image
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            // Username
            VStack(alignment: .leading, spacing: 4) {
                Text("USERNAME")
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
                logOutOption.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color(.label))
            }
        }
        .padding()
        
        // Log out banner functionality
        .actionSheet(isPresented: $logOutOption) {
            .init(title: Text("Settings"), message:
                    Text("What do you want to do ?"), buttons: [
                        .destructive(Text("Sign Out"), action: {
                            print("handle sign out")
                        }),
                        .cancel()
                    ])
        }
    }
}

//MARK: - Preview
#Preview {
    MessageNavBar()
}
