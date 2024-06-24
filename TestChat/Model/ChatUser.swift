//
//  Model.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import Foundation

struct ChatUser: Identifiable, Codable {
    
    var id: String { uid }
    
    let uid, email, nickname, profileImageUrl: String
    
    init (data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.nickname = data["nickname"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}


