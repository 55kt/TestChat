//
//  MessageButton.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import SwiftUI

struct MessageButton: View {
    var body: some View {
        Button{
            // some action
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
    }
}

#Preview {
    MessageButton()
}
