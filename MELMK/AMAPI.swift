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
    var player: MPMusicPlayerApplicationController?
    private var cancellables = [AnyCancellable]()
    
    @Published var isAuthorized: Bool = false
    @Published var nowPlayingItem: MPMediaItem?
    @Published var isPlaying: Bool?
    
    
    override init() {
        print("AMAPI Initialized.")
        
        super.init()
        
        self.skAuth()
        guard SKCloudServiceController.authorizationStatus() == .authorized else { return }
        self.playbackCapability()
        
        let nowPlayingCancellable = NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)
            .sink(receiveValue: { note in
                print("Notification Received!")
                let playerController = note.object as! MPMusicPlayerApplicationController
                self.nowPlayingItem = playerController.nowPlayingItem
            })
        cancellables.append(nowPlayingCancellable)
        
        let playbackStateCancellable = NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)
            .sink(receiveValue: { note in
                print("Playback State Changed!")
                let playerController = note.object as! MPMusicPlayerApplicationController
                switch playerController.playbackState {
                case .playing:
                    self.isPlaying = true
                default:
                    self.isPlaying = false
                }
            })
        cancellables.append(playbackStateCancellable)
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
    
    func playPause() {
        switch player?.playbackState {
        case .paused:
            player?.play()
        case .playing:
            player?.pause()
        default:
            break
        }
    }
    
    func startOrPrev() {
        guard let currTime = player?.currentPlaybackTime else { return }
        print("Current Time: \(currTime)")
        if currTime < 2.0 {
            player?.skipToPreviousItem()
        } else {
            player?.skipToBeginning()
        }
    }
}
