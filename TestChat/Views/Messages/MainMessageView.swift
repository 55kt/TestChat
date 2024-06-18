//
//  MainMessageView.swift
//  TestChat
//
//  Created by Vlad on 18/6/24.
//

import SwiftUI

struct MainMessageView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 34, weight: .heavy))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("USERNAME")
                            .font(.system(size: 24, weight: .bold))
                        HStack {
                            Circle()
                                .foregroundStyle(.green)
                                .frame(width: 14, height: 14)
                            Text("Online")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.lightGray))
                        }
                    }
                    
                    Spacer()
                    Image(systemName: "gear")
                }
                .padding()
                
                ScrollView {
                    ForEach(0..<10, id: \.self) {num in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
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
                .navigationTitle("Main Message View")
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    MainMessageView()
}
