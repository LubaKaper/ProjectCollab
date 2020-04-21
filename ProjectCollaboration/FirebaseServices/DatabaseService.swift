//
//  DatabaseService.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseServices {
    
    static let postCollection = "posts"
    
    private let db = Firestore.firestore()
    
    private init()  {}
    static let shared = DatabaseServices()
    
    public func fetchAllPost(completionHandler: @escaping (Result<[Post], Error>) -> ()) {
        db.collection(DatabaseServices.postCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map {Post($0.data())}
                completionHandler(.success(posts))
            }
        }
    }
}
