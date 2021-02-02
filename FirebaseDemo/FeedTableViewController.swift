//
//  FeedTableViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 21/6/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ImagePicker
import Firebase

class FeedTableViewController: UITableViewController {
    
    var postFeed: [Post] = []
    fileprivate var isLoadingPost = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.black
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(loadRecentPosts), for: UIControl.Event.valueChanged)
        
        loadRecentPosts()
    }
    
    @IBAction func openCamera(_ sender: Any) {
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func loadRecentPosts() {
        
        isLoadingPost = true
        PostService.shared.getRecentPosts(start: postFeed.first?.timestamp, limit: 7) { (newPosts) in
            
            if newPosts.count > 0 {
                self.postFeed.insert(contentsOf: newPosts, at: 0)
            }
            
            self.isLoadingPost = false
            if let _ = self.refreshControl?.isRefreshing {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.refreshControl?.endRefreshing()
                    self.displayNewPosts(newPosts: newPosts)
                }
            } else {
                self.displayNewPosts(newPosts: newPosts)
            }
        }
    }
    
    private func displayNewPosts(newPosts posts: [Post]) {
        
        guard posts.count > 0 else {
            return
        }
        
        var indexPaths: [IndexPath] = []
        self.tableView.beginUpdates()
        
        for currentRow in 0...(posts.count - 1) {
            let indexPath = IndexPath(row: currentRow, section: 0)
            indexPaths.append(indexPath)
        }
        
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
    }
}

extension FeedTableViewController: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        guard let image = images.first else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        PostService.shared.uploadImage(image: image) {
            self.dismiss(animated: true, completion: nil)
            self.loadRecentPosts()
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension FeedTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let safeCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        let currentPost = postFeed[indexPath.row]
        safeCell.configure(post: currentPost)
        
        return safeCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard !isLoadingPost, postFeed.count - indexPath.row == 2 else {
            return
        }
        
        isLoadingPost = true
        
        guard let lastPostTimestamp = postFeed.last?.timestamp else {
            isLoadingPost = false
            return
        }
        
        PostService.shared.getOldPosts(start: lastPostTimestamp, limit: 5) { (newPosts) in
            
            var indexPaths: [IndexPath] = []
            self.tableView.beginUpdates()
            for newPost in newPosts {
                self.postFeed.append(newPost)
                let indexPath = IndexPath(row: self.postFeed.count - 1, section: 0)
                indexPaths.append(indexPath)
            }
            
            self.tableView.insertRows(at: indexPaths, with: .fade)
            self.tableView.endUpdates()
            
            self.isLoadingPost = false 
        }
    }
}
