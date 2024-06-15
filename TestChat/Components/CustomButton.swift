//
//  CustomButton.swift
//  TestChat
//
//  Created by Vlad on 15/6/24.
//

import SwiftUI

struct CustomButton: View {
    
    //MARK: - Properties
    let buttonTitle: String
    let action: () -> ()
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(buttonTitle)
                    .font(.headline)
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(16)
            }
        }
    }
}

#Preview {
    CustomButton(buttonTitle: "Custom Button") {}
}
