//
//  UserModel.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Professional {
    let bio: String
    let email: String
    let location: String
    let name: String
    let occupation: String
    let proId: String
    let imageURL: String
}

extension Professional {
    init(_ dictionary: [String: Any]) {
        self.bio = dictionary["bio"] as? String ?? "no bio"
        self.email = dictionary["email"] as? String ?? "no email"
        self.location = dictionary["location"] as? String ?? "no location"
        self.name = dictionary["name"] as? String ?? "no name"
        self.occupation = dictionary["occupation"] as? String ?? "no occupation"
        self.proId = dictionary["proId"] as? String ?? "no id"
        self.imageURL = dictionary["imageURL"] as? String ?? "no imageURL"
    }
}
