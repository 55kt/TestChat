//
//  PasswordField.swift
//  TestChat
//
//  Created by Vlad on 15/6/24.
//

import SwiftUI

struct PasswordField: View {
    
    //MARK: - Properties
    @Binding var password: String
    @State private var isSecure: Bool = true
    
    //MARK: - Body
    var body: some View {
        HStack {
            if isSecure {
                SecureField("Password", text: $password)
            } else {
                TextField("Password", text: $password)
            }
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                    .foregroundStyle(.gray)
            }
        }
    }
}

//MARK: - Preview
#Preview {
    PasswordField(password: .constant(""))
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
}
