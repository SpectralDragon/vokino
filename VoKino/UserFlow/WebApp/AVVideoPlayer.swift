//
//  AVVideoPlayer.swift
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

import SwiftUI
import AVKit

struct AVVideoPlayer: UIViewControllerRepresentable {
    
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = context.coordinator
        playerViewController.allowsPictureInPicturePlayback = true
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { 
        
    }
    
    func makeCoordinator() -> AVVideoPlayerCoordinator {
        return AVVideoPlayerCoordinator()
    }
}


class AVVideoPlayerCoordinator: NSObject, AVPlayerViewControllerDelegate {
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        // Dismiss the controller when PiP starts so that the user is returned to the item selection screen.
        return true
    }
}
