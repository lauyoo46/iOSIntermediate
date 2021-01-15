//
//  MIME.swift
//  EmailAttachment
//
//  Created by Laurentiu Ile on 12/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

enum MIMEType: String {
    
    case jpg = "image/jpeg"
    case png = "image/png"
    case doc = "application/msword"
    case ppt = "application/vnd.ms-powerpoint"
    case html = "text/html"
    case pdf = "application/pdf"
    
    init?(type: String) {
        switch type.lowercased() {
        case "jpg":
            self = .jpg
        case "png":
            self = .png
        case "doc":
            self = .doc
        case "ppt":
            self = .ppt
        case "html":
            self = .html
        case "pdf":
            self = .pdf
        default:
            return nil
        }
    }
}
