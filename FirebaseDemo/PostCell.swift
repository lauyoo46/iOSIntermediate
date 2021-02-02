//
//  PostCell.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 21/6/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var voteButton: LineButton! {
        didSet {
            voteButton.tintColor = .white
        }
    }
    
    @IBOutlet var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
            avatarImageView.clipsToBounds = true
        }
    }
    
    private var currentPost: Post?

    func configure(post: Post) {
        
        selectionStyle = .none
        currentPost = post
        
        nameLabel.text = post.user
        voteButton.setTitle("\(post.votes)", for: .normal)
        voteButton.tintColor = .white
        
        photoImageView.image = nil
        
        if let image = CacheManager.shared.getFromCache(key: post.imageFileURL) as? UIImage {
            photoImageView.image = image
        } else {
            
            if let url = URL(string: post.imageFileURL) {
                let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    guard let imageData = data else {
                        return
                    }
                    
                    OperationQueue.main.addOperation {
                        guard let image = UIImage(data: imageData) else { return }
                        
                        if self.currentPost?.imageFileURL == post.imageFileURL {
                            self.photoImageView.image = image
                        }
                        
                        CacheManager.shared.cache(object: image, key: post.imageFileURL)
                    }
                }
                
                downloadTask.resume()
            }
        }
    }
}
