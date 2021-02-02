//
//  PostService.swift
//  FirebaseDemo
//
//  Created by Laurentiu Ile on 02/02/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
final class PostService {
    
    static let shared: PostService = PostService()
    
    private init() { }
    
    let BASE_DB_REF: DatabaseReference = Database.database(url: "https://fir-demo-52831-default-rtdb.firebaseio.com/")
                                                 .reference()
    let POST_DB_REF: DatabaseReference = Database.database(url: "https://fir-demo-52831-default-rtdb.firebaseio.com/")
                                                 .reference().child("posts")
    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
    
    func uploadImage(image: UIImage, completionHandler: @escaping () -> Void) {
        let postDatabaseRef = POST_DB_REF.childByAutoId()
        
        guard let imageKey = postDatabaseRef.key else {
            return
        }
        
        let imageStorageRef = PHOTO_STORAGE_REF.child("\(imageKey).jpg")
        let scaledImage = image.scale(newWidth: 640.0)
        
        guard let imageData = scaledImage.jpegData(compressionQuality: 0.9) else {
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
        uploadTask.observe(.success) { (snapshot) in
            
            guard let displayName = Auth.auth().currentUser?.displayName else {
                return
            }
            
            snapshot.reference.downloadURL { (url, error) in
                guard let url = url else {
                    return
                }
                
                let imageFileURL = url.absoluteString
                let timestamp = Int(Date().timeIntervalSince1970 * 1000)
                
                let post: [String : Any] = [ "imageFileURL" : imageFileURL,
                                             "votes" : Int(0),
                                             "user" : displayName,
                                             "timestamp" : timestamp ]
                postDatabaseRef.setValue(post)
            }
            
            completionHandler()
        }
        uploadTask.observe(.progress) { (snapshot) in
            
            let percentComplete = 100.0 * Double(snapshot.progress?.completedUnitCount ?? 0) / Double(snapshot.progress?.totalUnitCount ?? 100)
            print("Uploading... \(percentComplete)% complete")
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getRecentPosts(start timestamp: Int? = nil, limit: UInt, completionHandler: @ escaping ([Post]) -> Void) {
        var postQuery = POST_DB_REF.queryOrdered(byChild: Post.PostInfoKey.timestamp)
        
        if let latestPostTimestamp = timestamp, latestPostTimestamp > 0 {
            postQuery = postQuery.queryStarting(atValue: latestPostTimestamp + 1,
                                                childKey: Post.PostInfoKey.timestamp).queryLimited(toLast: limit)
        } else {
            postQuery = postQuery.queryLimited(toLast: limit)
        }
        
        postQuery.observeSingleEvent(of: .value) { (snapshot) in
            
            var newPosts: [Post] = []
            if let items = snapshot.children.allObjects as? [DataSnapshot] {
                
                for item in items {
                    let postInfo = item.value as? [String: Any] ?? [:]
                    if let post = Post(postId: item.key, postInfo: postInfo) {
                        newPosts.append(post)
                    }
                }
                
                if newPosts.count > 0 {
                    newPosts.sort(by: { $0.timestamp > $1.timestamp })
                }
                
                completionHandler(newPosts)
            }
        }
    }
    
    func getOldPosts(start timestamp: Int, limit: UInt, completionHandler: @escaping ( [Post]) -> Void) {
        
        let postOrderedQuery = POST_DB_REF.queryOrdered(byChild: Post.PostInfoKey.timestamp)
        let postLimitedQuery = postOrderedQuery.queryEnding(atValue: timestamp - 1,
                                                            childKey: Post.PostInfoKey.timestamp).queryLimited(toLast: limit)
        
        postLimitedQuery.observeSingleEvent(of: .value) { (snapshot) in
            
            var newPosts: [Post] = []
            if let items = snapshot.children.allObjects as? [DataSnapshot] {
                
                for item in items {
                    let postInfo = item.value as? [String: Any] ?? [:]
                    
                    if let post = Post(postId: item.key, postInfo: postInfo) {
                        newPosts.append(post)
                    }
                }
                
                newPosts.sort(by: { $0.timestamp > $1.timestamp })
                completionHandler(newPosts)
            }
        }
    }
}
