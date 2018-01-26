//
//  AddRatingManager.swift
//  Mixer
//
//  Created by Duncan Du [MIGOTP] on 2018/1/25.
//  Copyright © 2018年 Razeware LLC. All rights reserved.
//

import Foundation
import React

@objc(AddRatingManager)
class AddRatingManager: RCTEventEmitter {
    
    override func supportedEvents() -> [String]! {
        return ["AddRatingManagerEvent"]
    }
    
    @objc func dismissPresentedViewController(_ reactTag: NSNumber) {
        DispatchQueue.main.async {
            if let view = self.bridge.uiManager.view(forReactTag: reactTag) {
                let presentedViewController: UIViewController! = view.reactViewController()
                presentedViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
    @objc func save(_ reactTag: NSNumber, rating: Int, forIdentifier identifier: Int) -> Void {
        // Save rating
        UserDefaults.standard.set(rating, forKey: "currentRating-\(identifier)")
        dismissPresentedViewController(reactTag)
        self.sendEvent(
            withName: "AddRatingManagerEvent",
            body: ["name": "saveRating", "message": rating, "extra": identifier])
    }
}
