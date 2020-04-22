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
    static let usersCollection = "professionals"
    
    
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
    
    public func createPost(title: String, date: String, category: String, location: String, description: String, profId: String, postedBy: String, completion: @escaping (Result<String, Error>)->()) {
        let document = db.collection(DatabaseServices.postCollection).document()
        
        db.collection(DatabaseServices.postCollection).document(document.documentID).setData(["category" : category, "description": description, "profId": profId, "postedBy": postedBy, "postTitle": title, "startDate": date]) { (error) in
            if let error = error {
                completion(.failure(error))
                print("could not create post")
            } else {
                completion(.success(document.documentID))
            }
        }
    }
    
    public func fetchAllUsers(completionHandler: @escaping (Result<[Professional], Error>) -> ()) {
        db.collection(DatabaseServices.usersCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else if let snapshot = snapshot {
                let users = snapshot.documents.map {Professional( $0.data())}
                completionHandler(.success(users))
            }
        }
    }
    
    
    public func addCollab(userName: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let document = db.collection(DatabaseServices.postCollection).document()
        db.collection(DatabaseServices.postCollection).document(document.documentID).updateData(["collaborators" : userName]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
