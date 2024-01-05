//
//  AppDelegate.swift
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

import UIKit
import AVKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private enum Constants {
        static let appCookiesKey = "AppCookies"
    }
    
    let defaults = UserDefaults.standard
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.restoreCookies()
        
        application.isIdleTimerDisabled = true
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.storeCookies()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.storeCookies()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.restoreCookies()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.restoreCookies()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.storeCookies()
    }
    
    // MARK: - Private
    
    private func storeCookies() {
        do {
            let cookies = try NSKeyedArchiver.archivedData(withRootObject: HTTPCookieStorage.shared.cookies ?? [], requiringSecureCoding: true)
            defaults.set(cookies, forKey: Constants.appCookiesKey)
        } catch {
            showFatalAlert(with: error)
        }
    }
    
    private func restoreCookies() {
        guard let data = defaults.object(forKey: Constants.appCookiesKey) as? Data, !data.isEmpty else {
            return
        }
        
        do {
            let cookies = try (NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data) as? [HTTPCookie]) ?? []
            for cookie in cookies {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        } catch {
            showFatalAlert(with: error)
        }
    }
    
    private func showFatalAlert(with error: Error) {
        let alert = UIAlertController(title: "Fatal Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Close", style: .destructive, handler: { _ in
            abort()
        }))
        window?.rootViewController?.presentingViewController?.present(alert, animated: true)
    }
    
}
