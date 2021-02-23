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
    
//    static var shared: MediaPickerController!
    var deleobj: AMAPI?
    
    func makeUIViewController(context: Context) -> MPMediaPickerController {
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.delegate = self.deleobj
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MPMediaPickerController, context: Context) {
        return
    }
    
}
