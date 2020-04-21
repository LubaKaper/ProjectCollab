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
    
    
}
