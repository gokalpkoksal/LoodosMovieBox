//
//  NetworkMonitor.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 17.04.2022.
//

import Foundation
import Network

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
}

final class NetworkMonitor: NetworkMonitorProtocol {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
}
