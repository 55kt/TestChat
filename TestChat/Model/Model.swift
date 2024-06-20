//
//  Model.swift
//  TestChat
//
//  Created by Vlad on 19/6/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var password: String
    var nickname: String
    
    init(id: String? = nil, email: String, password: String, nickname: String) {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
    }
}


