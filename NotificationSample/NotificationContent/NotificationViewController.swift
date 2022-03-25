//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Vijay on 22/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CoreMotion
import AVKit


enum MediaType: String {
    case image = "image"
    case video = "video"
    case audio = "audio"
    case gif = "gif"
    
    init?(value: String){
        switch value {
        case "image" : self = .image
        case "video" : self = .video
        case "gif" : self = .gif
        case "audio": self = .audio
        default : return nil
        }
    }
}

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var contentImage: UIImageView!
    var manager = CMMotionManager() // For moving image
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: size.height / 3)
        
        // Do any required interface initialization here.
    }
    
    
    func didReceive(_ notification: UNNotification) {
        
        let content = notification.request.content

        if let urlImageString = content.userInfo["urlImageString"] as? String {
            if let url = URL(string: urlImageString) {
                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                    if let _ = error {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.contentImage.image = UIImage(data: data)
                    }
                }
            }
        }
//        if let mediaType = notification.request.content.userInfo["mediaType"] as? String {
//            let type = MediaType(rawValue: mediaType)
//            switch type {
//            case .image:
//                if let urlString = notification.request.content.userInfo["attachment-url"] as! String? {
//                    self.contentImage.isHidden = false
//                    self.videoView.isHidden = true
//                    self.loadImage(mediaUrl: urlString)
//                }
//            case .video:
//                self.contentImage.isHidden = true
//                self.videoView.isHidden = false
//                self.loadViedeo(mediaUrl: notification.request.content.userInfo["attachment-url"] as? String)
//
//            case .audio:
//                self.contentImage.isHidden = false
//                self.videoView.isHidden = true
//                self.contentImage.image = UIImage(named: "image")
//                self.loadViedeo(mediaUrl: notification.request.content.userInfo["attachment-url"] as? String)
//            case .gif:
//                break
//            case .none:
//                break
//            }
//        }
        
    }
    
    func loadImage(mediaUrl: String) {
        if let imageURL = URL(string: mediaUrl) {
            if let data = NSData(contentsOf: imageURL) {
                self.contentImage.image = UIImage(data: data as Data)
            }
        }
    }
    
    func loadViedeo(mediaUrl: String?) {
        guard let strUrl = mediaUrl,
            let videoUrl = URL(string: strUrl) else {
                return
        }
        //If you want to try Steaming url video : http://clips.vorwaerts-gmbh.de/VfE_html5.mp4
        print(strUrl)
        
        let player : AVPlayer = AVPlayer(url: videoUrl)
        let playerLayer : AVPlayerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        player.actionAtItemEnd = .none
        playerLayer.frame = CGRect(x: 0, y: 0, width: self.videoView.frame.size.width, height: self.videoView.frame.size.height)
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    

}


extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
