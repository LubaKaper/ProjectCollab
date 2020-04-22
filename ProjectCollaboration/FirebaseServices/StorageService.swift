//
//  StorageService.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    private init() {}
    static let shared = StorageService()
    
    private let storageRef = Storage.storage().reference()
    
    public func fetchPhoto(filename: String, completion: @escaping (Result<URL, Error>) -> ()) {
        storageRef.child(filename).downloadURL { (url, error) in
            if let error = error {
                completion(.failure(error))
            } else if let url = url {
                completion(.success(url))
            }
        }
    }
    
    public func uploadPostPhoto(image: UIImage, postId: String, completion: @escaping (Result<URL, Error>)-> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        var photoReferance: StorageReference!
        photoReferance = storageRef.child("posts/\(postId).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let _ = photoReferance.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = metaData {
                photoReferance.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
}
