//
//  MainMessageView.swift
//  TestChat
//
//  Created by Vlad on 18/6/24.
//

import SwiftUI

struct MainMessageView: View {
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                // Nav Bar
                MessageNavBar()
                
                // Main View Content
                ScrollView {
                    ForEach(0..<10, id: \.self) {num in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(Color(.label), lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text("Username")
                                        .font(.system(size: 16, weight: .bold))
                                    Text("Message sent to user")
                                        .foregroundStyle(Color(.lightGray))
                                }
                                Spacer()
                                
                                Text("22:00")
                                    .font(.system(size:14, weight: .semibold))
                            }
                            Divider()
                                .padding(.vertical, 8)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 50)
                
                // Bottom bar button
                .overlay (
                    MessageButton(), alignment: .bottom
                )
                .navigationBarHidden(true)
            }
        }
    }
}

//MARK: - Preview
#Preview {
    MainMessageView()
        .preferredColorScheme(.dark)
}
