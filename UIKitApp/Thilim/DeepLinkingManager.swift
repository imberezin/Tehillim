//
//  DeepLinkManger.swift
//  Thilim
//
//  Created by Israel Berezin on 07/08/2017.
//  Copyright © 2017 Israel Berezin. All rights reserved.
//

import UIKit

let DeepLinkingM = DeepLinkingManager.sharedInstance


class DeepLinkingManager: NSObject {
    
    
    static let sharedInstance = DeepLinkingManager()
    
    public func registerDeepLinkingAction(_ url: URL) {
        if let host = url.host{
            print (host)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "KDeepLinkingActionNotification"), object: nil, userInfo: ["DeepLinkingPage" : host])
            }
        }
    }

    

}
