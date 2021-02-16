//
//  ViewController.swift
//  UserReviewMLModel
//
//  Created by Laurentiu Ile on 04/02/2021.
//

import UIKit
import NaturalLanguage
import CoreML

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emojiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.text = "🤷🏻‍♂️"
        emojiLabel.font = UIFont.systemFont(ofSize: 150.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        textView.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func classifyReview(review: String) {
        
        if let modelURL = Bundle.main.url(forResource: "SentimentClassifier", withExtension: "mlmodelc") {
            do {
                let model = try NLModel(contentsOf: modelURL)
                
                let prediction = model.predictedLabel(for: review)
                emojiLabel.text = prediction == "positive" ? "👍" : "👎"
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ReviewViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            emojiLabel.text = "🤷🏻‍♂️"
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        classifyReview(review: textView.text)
    }
}
