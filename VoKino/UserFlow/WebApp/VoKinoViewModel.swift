//
//  VoKinoViewModel.swift
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

import SwiftUI
import AVFoundation

@Observable
class VoKinoViewModel: NSObject {
    
    weak var webView: WebView?
    
    enum RemoteControlCommand {
        case left
        case right
        case up
        case down
        
        case select
        case playPause
        case exit
    }
    
    var videoPlayer: AVPlayer?
    var isShowPlayer: Bool = false
    private(set) var isFirstLoading: Bool = true
    private(set) var isLoading: Bool = false
    var error: Error?
    var isErrorShown = false

    func processRemoteCommand(_ command: RemoteControlCommand) {
        switch command {
        case .left:
            dispatchKeyboardEvent("keydown", keyCode: 37)
        case .right:
            dispatchKeyboardEvent("keydown", keyCode: 39)
        case .up:
            dispatchKeyboardEvent("keydown", keyCode: 38)
        case .down:
            dispatchKeyboardEvent("keydown", keyCode: 40)
        case .playPause:
            dispatchKeyboardEvent("keydown", keyCode: 71)
        case .exit:
            dispatchKeyboardEvent("keydown", keyCode: 27)
        case .select:
            dispatchKeyboardEvent("keyup", keyCode: 0xd)
        }
    }
    
    func stopStreaming() {
        self.videoPlayer = nil
    }
    
    // MARK: - Private
    
    private func dispatchKeyboardEvent(_ type: String, keyCode: Int) {
        webView?.stringByEvaluatingJavaScript(from: "window.dispatchEvent( new KeyboardEvent('\(type)', { keyCode : '\(keyCode)' }) );")
    }
    
    private func console(_ string: String) {
        let result = webView?.stringByEvaluatingJavaScript(from: string)
        print(result)
    }

    private func showError(_ error: Error) {
        self.error = error
        self.isErrorShown = true
    }
}

// MARK: - WebViewDelegate

extension VoKinoViewModel: WebViewDelegate {
    
    func webViewDidStartLoad(_ webView: WebView) {
        self.isLoading = true
    }
    
    func webViewDidFinishLoad(_ webView: WebView) {
        self.isFirstLoading = false
        self.isLoading = false
//        
//        let javaScript = """
//        setTimeout(() => {
//            document.querySelector('.e-search.selector').click();
//            // document.querySelector('.b-search__field').focus();
//
//            setTimeout(() => {
//                document.querySelector('.b-search__field').value = 'batman';
//            }, 1000);
//        }, 4000);
//"""
//        
//        console(javaScript)
    }
    
    func webView(_ webView: WebView, didFailLoadWithError error: Error) {
        showError(error)
    }

    func webView(_ webView: WebView, shouldStartLoadWith request: URLRequest?, navigationType: Int) -> Bool {
        if let url = request?.url, !url.pathExtension.isEmpty {
            let item = AVPlayerItem(url: url)
            item.externalMetadata = createMetadataItems(for: url)
            self.videoPlayer = AVPlayer(playerItem: item)
            self.isShowPlayer = true
            
            return false
        }
        
        return true
    }
    
    private func createMetadataItem(for identifier: AVMetadataIdentifier,
                                    value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        // Specify "und" to indicate an undefined language.
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
    
    func createMetadataItems(for metadata: URL) -> [AVMetadataItem] {
        let mapping: [AVMetadataIdentifier: Any] = [ :
//            .commonIdentifierTitle: metadata.title,
//            .iTunesMetadataTrackSubTitle: metadata.subtitle,
//            .commonIdentifierArtwork: UIImage(named: metadata.image)?.pngData() as Any,
//            .commonIdentifierDescription: metadata.description,
//            .iTunesMetadataContentRating: metadata.rating,
//            .quickTimeMetadataGenre: metadata.genre
        ]
        return mapping.compactMap { createMetadataItem(for:$0, value:$1) }
    }
}
