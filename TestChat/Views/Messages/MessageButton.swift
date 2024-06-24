//
//  MessageButton.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import SwiftUI

struct MessageButton: View {
    
    @State var shouldShowNewMessageScreen = false
    
    var body: some View {
        Button{
            shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.vertical)
            .background(.blue)
            .cornerRadius(24)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
            NewMessageView()
        }
    }
}

#Preview {
    MessageButton()
}
