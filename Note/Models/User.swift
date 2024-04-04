//
//  User.swift
//  Note
//
//  Created by นายธนภัทร สาระธรรม on 4/4/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
