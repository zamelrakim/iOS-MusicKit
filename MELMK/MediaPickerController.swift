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
        var amapi: AMAPI
        var player: MPMusicPlayerApplicationController?
        
        init(_ mediaPickerController: MediaPickerController) {
            parent = mediaPickerController
            amapi = parent.delegateObj!
            player = amapi.player
        }
        
        func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            
            player?.perform(queueTransaction: { currQueue in
                let itemsCount = currQueue.items.count
                
                if itemsCount == 0 {
                    self.player?.setQueue(with: mediaItemCollection)
                } else {
                    let queueDescriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: mediaItemCollection)
                    currQueue.insert(queueDescriptor, after: currQueue.items.last)
                }
            }, completionHandler: {(updatedQueue, err) in
                if (err != nil) { print(err!) }
                self.amapi.queue = updatedQueue.items
            })
            
            mediaPicker.dismiss(animated: true)
            player?.prepareToPlay()
            player?.beginGeneratingPlaybackNotifications()
            player?.play()
        }
        
        func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
            mediaPicker.dismiss(animated: true)
        }
    }
}
