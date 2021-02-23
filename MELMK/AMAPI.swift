//
//  AMAPI.swift
//  MELMK
//
//  Created by Zamel Rakim on 1/4/21.
//

import Foundation
//import Combine
import StoreKit
import MediaPlayer

class AMAPI: NSObject, ObservableObject, MPMediaPickerControllerDelegate {
    var musicController = SKCloudServiceController()
    @Published var isAuthorized: Bool = false
    var player: MPMusicPlayerController?
    
    override init() {
        print("AMAPI Initialized.")
        
        super.init()
        
        
        
        self.skAuth()
        guard SKCloudServiceController.authorizationStatus() == .authorized else { return }
        self.playbackCapability()
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
                self.createPlayer()
            }
        })
    }
    
    func createPlayer() {
        print("Creating Music Player...")
        player = MPMusicPlayerApplicationController.applicationQueuePlayer
//        THERE IS AN ERROR WHEN ADDING THE SONGS TO THE QUEUE
        player?.setQueue(with: .songs())
        player?.play()
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print("Choose A Song")
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        print("Canceled Media Picker")
    }
}
