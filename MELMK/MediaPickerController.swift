//
//  MediaPickerController.swift
//  MELMK
//
//  Created by Zamel Rakim on 1/11/21.
//

import SwiftUI
import UIKit
import MediaPlayer

struct MediaPickerController : UIViewControllerRepresentable {
    typealias UIViewControllerType = MPMediaPickerController
    
    var delegateObj: AMAPI?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MPMediaPickerController {
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.allowsPickingMultipleItems = true
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MPMediaPickerController, context: Context) {
        return
    }
    
    class Coordinator: NSObject, MPMediaPickerControllerDelegate {
        var parent: MediaPickerController
        var player: MPMusicPlayerApplicationController?
        
        init(_ mediaPickerController: MediaPickerController) {
            parent = mediaPickerController
            player = parent.delegateObj?.player
        }
        
        func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            print("Choose A Song(s)")
            
            player?.setQueue(with: mediaItemCollection)
            mediaPicker.dismiss(animated: true)
            player?.prepareToPlay()
            player?.beginGeneratingPlaybackNotifications()
            player?.play()
        }
        
        func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
            print("Canceled Media Picker")
            mediaPicker.dismiss(animated: true)
        }
    }
}
