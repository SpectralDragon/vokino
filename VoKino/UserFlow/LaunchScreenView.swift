//
//  LaunchScreenView.swift
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

import SwiftUI

struct LaunchScreenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController()!
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
