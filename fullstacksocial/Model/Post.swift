//
//  Post.swift
//  fullstacksocial
//
//  Created by wizz on 10/12/21.
//

import Foundation

struct Post: Decodable {
    let id: String
    let text: String
    let createdAt: Int
    let imageUrl: String
    let user: User
    
    var fromNow: String?
    
    var comments: [Comment]?
    
    var hasLiked: Bool?
    
    var numLikes: Int
}


enum Result<Success, Failure> where Failure : Error {

    /// A success, storing a `Success` value.
    case success(Success)

    /// A failure, storing a `Failure` value.
    case failure(Failure)
}
