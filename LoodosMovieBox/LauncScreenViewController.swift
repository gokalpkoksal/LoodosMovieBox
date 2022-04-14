//
//  LauncScreenViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation
import FirebaseRemoteConfig
import UIKit

class LaunchScreenViewController: UIViewController {
    
    // connect with launchscreen storyboard
    @IBOutlet weak var label_loodos: UILabel!
    private let remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRemoteValues()
    }

    func fetchRemoteValues() {
        let defaults: [String: NSObject] = ["text_loodos_remote": "loodos_default" as NSObject]
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _, error in
                    guard error == nil else {
                        return
                    }
                    
                    if let fetchedValue = self.remoteConfig.configValue(forKey: "text_loodos_remote").stringValue {
                        self.label_loodos.text = fetchedValue
                        print("fetched: \(fetchedValue)")
                    }
                }
            } else {
                print("sth went wrong!")
            }
        })
    }
}
