//
//  MessagesViewController.swift
//  IconStore
//
//  Created by Laurentiu Ile on 27/01/2021.
//

import UIKit
import Messages
import IconDataKit

class MessagesViewController: MSMessagesAppViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var iconSet = IconData.iconSet
    private var selectedIcon: Icon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        if presentationStyle == .compact {
            dismiss(animated: false, completion: nil)
            return
        }
    }
    
    override func willBecomeActive(with conversation: MSConversation) {
        guard presentationStyle == .expanded else {
            dismiss(animated: false, completion: nil)
            return
        }
        
        if let selectedMessage = conversation.selectedMessage {
            presentIconDetails(message: selectedMessage)
        }
    }
    
    func presentIconDetails(message: MSMessage) {
        selectedIcon = Icon(message: message)
        performSegue(withIdentifier: "IconDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
           identifier == "IconDetail" {
            if let destinationController = segue.destination as? IconDetailViewController {
                destinationController.icon = selectedIcon
            }
        }
    }
}

extension MessagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let safeCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                as? IconTableViewCell else {
            return UITableViewCell()
        }
        
        let icon = iconSet[indexPath.row]
        safeCell.nameLabel.text = icon.name
        safeCell.descriptionLabel.text = icon.description
        safeCell.priceLabel.text = "$\(icon.price)"
        safeCell.iconImageView.image = UIImage(named: icon.imageName)
        
        return safeCell
    }
    
    override func didSelect(_ message: MSMessage, conversation: MSConversation) {
        guard let selectedMessage = conversation.selectedMessage else {
            return
        }
        
        presentIconDetails(message: selectedMessage)
    }
}

extension MessagesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        requestPresentationStyle(.compact)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let icon = iconSet[indexPath.row]
        
        if let conversation = activeConversation {
            let messageLayout = MSMessageTemplateLayout()
            messageLayout.caption = icon.name
            messageLayout.subcaption = "$\(icon.price)"
            messageLayout.image = UIImage(named: icon.imageName)
            
            let message = MSMessage()
            message.layout = messageLayout
            
            if var components = URLComponents(string: "http://www.appcoda.com") {
                components.queryItems = icon.queryItems
                message.url = components.url
            }
            
            conversation.insert(message, completionHandler: { (error) in
                if let error = error {
                    print(error)
                }
            })
        }
    }
}
