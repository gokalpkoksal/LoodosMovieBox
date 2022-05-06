//
//  FirebaseService.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 29.04.2022.
//

import Foundation
import FirebaseAnalytics
import FirebaseRemoteConfig

protocol AppNameServiceProtocol {
    func getAppName(completion: @escaping (String) -> Void)
}

class FirebaseService: AppNameServiceProtocol {
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() { }
    
    func getAppName(completion: @escaping (String) -> Void) {
        let defaults: [String: NSObject] = ["text_loodos_remote": "loodos_default" as NSObject]
        remoteConfig.setDefaults(defaults)

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { [weak self] status, error in
            guard let self = self else {
                return
            }

            if status == .success, error == nil {
                self.remoteConfig.activate { _, error in
                    guard error == nil else {
                        return
                    }

                    if let fetchedValue = self.remoteConfig.configValue(forKey: "text_loodos_remote").stringValue {
                        DispatchQueue.main.async {
                            completion(fetchedValue)
                        }
                    }
                }
            } else {
                print("sth went wrong!")
            }
        })
    }
}

protocol FirebaseAnalyticsServiceProtocol {
    func logEvent(name: String, parameters: [String : Any]?)
}

class AnalyticsService: FirebaseAnalyticsServiceProtocol {
    
    func logEvent(name: String, parameters: [String : Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
}

enum AnalyticsEventName {
    static let movieDetails = "movieDetails"
}

enum AnalyticsEventParameterName {
    static let movieName = "movie name"
    static let movieYear = "movie year"
}
    
