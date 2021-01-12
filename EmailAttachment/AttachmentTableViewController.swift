//
//  AttachmentTableViewController.swift
//  EmailAttachment
//
//  Created by Simon Ng on 5/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MessageUI

class AttachmentTableViewController: UITableViewController {
    
    let filenames = ["10 Great iPhone Tips.pdf",
                     "camera-photo-tips.html",
                     "foggy.jpg",
                     "Hello World.ppt",
                     "no more complaint.png",
                     "Why Appcoda.doc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func sendSMS(attachment: String) {
        
        guard MFMessageComposeViewController.canSendText() else {
            let alertMessage = UIAlertController(title: "SMS Unavailable",
                                                 message: "Your device is not capable of sending SMS.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            return
        }
        
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = self
        messageController.recipients = ["12345678", "72345524"]
        messageController.body = "Just sent the \(attachment) to your email. Please check!"
          
        let fileparts = attachment.components(separatedBy: ".")
        let filename = fileparts[0]
        let fileExtension = fileparts[1]
        let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension)
        let fileUrl = NSURL.fileURL(withPath: filePath!)
        messageController.addAttachmentURL(fileUrl, withAlternateFilename: nil)
        
        present(messageController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filenames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row)");
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = filenames[indexPath.row]
        sendSMS(attachment: selectedFile)
    }
}

    // MARK: - MFMAILComposeViewControllerDelegate methods

extension AttachmentTableViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case MessageComposeResult.cancelled:
            print("SMS cancelled")
            
        case MessageComposeResult.failed:
            let alertMessage = UIAlertController(title: "Failure",
                                                 message: "Failed to send the message.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
        case MessageComposeResult.sent:
            print("SMS sent")
            
        @unknown default:
            print("Unknown error")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
