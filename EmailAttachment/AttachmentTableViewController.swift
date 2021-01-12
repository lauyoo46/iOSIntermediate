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
    
    func showEmail(attachment: String) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("This device doesn't allow you to send mail.")
            return
        }
        
        let emailTitle = "Great Photo and Doc"
        let messageBody = "Hey, check this out!"
        let toRecipients = ["support@appcoda.com"]
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        let fileParts = attachment.components(separatedBy: ".")
        let fileName = fileParts[0]
        let fileExtension = fileParts[1]
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            return
        }
        
        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let mimeType = MIMEType(type: fileExtension) {
            
            mailComposer.addAttachmentData(fileData, mimeType: mimeType.rawValue, fileName: fileName)
            
            present(mailComposer, animated: true, completion: nil)
        }
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
        showEmail(attachment: selectedFile)
    }
    
}

    // MARK: - MFMAILComposeViewControllerDelegate methods

extension AttachmentTableViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Failed to send: \(error?.localizedDescription ?? "")")
        @unknown default:
            print("Unknown error")
        }
        dismiss(animated: true, completion: nil)
    }
}
