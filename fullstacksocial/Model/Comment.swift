//
//  Comment.swift
//  fullstacksocial
//
//  Created by wizz on 10/20/21.
//

import Foundation

struct Comment: Decodable {
    let text: String
    let user: User
    let fromNow: String
}
