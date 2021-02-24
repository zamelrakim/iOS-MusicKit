//
//  AMAPI.swift
//  MELMK
//
//  Created by Zamel Rakim on 1/4/21.
//

import Foundation
import Combine
import StoreKit
import MediaPlayer

class AMAPI: NSObject, ObservableObject {
    var musicController = SKCloudServiceController()
    @Published var isAuthorized: Bool = false
    var player: MPMusicPlayerApplicationController?
    @Published var nowPlayingItem: MPMediaItem?
    private var cancellable: AnyCancellable?
    
    override init() {
        print("AMAPI Initialized.")
        
        super.init()
        
        self.skAuth()
        guard SKCloudServiceController.authorizationStatus() == .authorized else { return }
        self.playbackCapability()
        
        cancellable = NotificationCenter.default.publisher(for: .MPMusicPlayerControllerQueueDidChange)
            .sink(receiveValue: { _ in
                print("Notification Received!")
                self.nowPlayingItem = self.player?.nowPlayingItem
            })
    }
    
    func skAuth() {
        print("Checking Store Kit Auth...")
        guard SKCloudServiceController.authorizationStatus() == .notDetermined else { return }
        
        SKCloudServiceController.requestAuthorization {(status: SKCloudServiceAuthorizationStatus) in
            print("Music Auth: \(String(describing: status.rawValue))")
        }
    }
    
    func playbackCapability() {
        print("Checking Music Playback Capability...")
        musicController.requestCapabilities(completionHandler: {(capabilities: SKCloudServiceCapability, error: Error?) in
            guard error == nil else { return }
            if capabilities.contains(.musicCatalogPlayback) {
                print("Apple Music Playback Capability Authorized.")
                self.isAuthorized = true
                self.player = MPMusicPlayerApplicationController.applicationQueuePlayer
            }
        })
    }
}
