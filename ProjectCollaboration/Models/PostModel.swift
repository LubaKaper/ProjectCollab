//
//  PostModel.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Post {
    let category: String
    let description: String
    let profId: String
    let postedBy: String
    let postTitle: String
    let startDate: String
    let imageURL: String
}
extension Post {
    init(_ dictionary: [String: Any]) {
        self.category = dictionary["category"] as? String ?? "no category"
        self.description = dictionary["description"] as? String ?? "no description"
        self.profId = dictionary["profId"] as? String ?? "no id"
        self.postedBy = dictionary["postedBy"] as? String ?? "mo name"
        self.postTitle = dictionary["postTitle"] as? String ?? "no title"
        self.startDate = dictionary["startDate"] as? String ?? "no date"
        self.imageURL = dictionary["imageURL"] as? String ?? "no image url"
    }
}
