//
//  VoKinoApp.swift
//  VoKino
//
//  Created by v.prusakov on 12/19/23.
//

import SwiftUI

@main
struct VoKinoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            VoKinoView()
                .ignoresSafeArea(edges: .all)
        }
    }
}
