//
//  NotificationViewController.swift
//  DetailNotification
//
//  Created by Dmitrii Ziablikov on 09.04.2018.
//  Copyright © 2018 Dmitrii Ziablikov. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVFoundation

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width / 2)
    }
    
    func didReceive(_ notification: UNNotification) {
    
        let content = notification.request.content
        
        self.titleLabel.text = content.title
        self.subtitleLabel.text = content.body
        
        guard let attachment = notification.request.content.attachments.first else { return }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            guard let imageData = try? Data.init(contentsOf: attachment.url) else { return }
            imageView.image = UIImage(data: imageData)
        }
        attachment.url.stopAccessingSecurityScopedResource()
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {

        if response.actionIdentifier == "print_action" {
            self.subtitleLabel.text = "Напечатали текст! Все ок!"
            completion(.doNotDismiss)
        } else if response.actionIdentifier == "comment_action" {
            
            let res = response as! UNTextInputNotificationResponse
            self.titleLabel.text = res.userText
            completion(.doNotDismiss)
        }
        
        completion(.doNotDismiss)

    }

}
