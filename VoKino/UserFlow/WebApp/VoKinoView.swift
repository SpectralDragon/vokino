//
//  VoKinoView.swift
//  VoKino
//
//  Created by v.prusakov on 12/19/23.
//

import SwiftUI
import AVKit

struct VoKinoView: View {
    
    @State private var viewModel = VoKinoViewModel()

    var body: some View {
        webApp
            .fullScreenCover(isPresented: $viewModel.isShowPlayer, onDismiss: viewModel.stopStreaming) {
                AVVideoPlayer(player: viewModel.videoPlayer!)
                    .onAppear {
                        viewModel.videoPlayer?.play()
                    }
                    .ignoresSafeArea(.all)
            }
            .alert("Error", isPresented: $viewModel.isShowPlayer) {
                Button("Close") {
                    viewModel.isShowPlayer = false
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "Error")
            }
    }
    
    var webApp: some View {
        UIKitWebView(viewModel: $viewModel)
            .focusable(interactions: .activate)
            .onMoveCommand { direction in
                switch direction {
                case .down:
                    viewModel.processRemoteCommand(.down)
                case .up:
                    viewModel.processRemoteCommand(.up)
                case .left:
                    viewModel.processRemoteCommand(.left)
                case .right:
                    viewModel.processRemoteCommand(.right)
                @unknown default:
                    fatalError()
                }
            }
            .onExitCommand {
                viewModel.processRemoteCommand(.exit)
            }
            .onPlayPauseCommand {
                viewModel.processRemoteCommand(.playPause)
            }
            .onTapGesture {
                viewModel.processRemoteCommand(.select)
            }
            .overlay {
                if viewModel.isFirstLoading {
                    LaunchScreenView()
                }
                
                if viewModel.isLoading && !viewModel.isFirstLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
    }
}

struct UIKitWebView: UIViewRepresentable {
    
    @Binding var viewModel: VoKinoViewModel

    func makeUIView(context: Context) -> WebView {
        let webView = WebView()
        webView.backgroundColor = .black
        webView.isUserInteractionEnabled = false
        webView.delegate = viewModel
        let request = URLRequest(
            url: URL(string: "http://web.vokino.tv")!,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 20
        )
        webView.load(by: request)
        viewModel.webView = webView
        return webView
    }
    
    func updateUIView(_ webView: WebView, context: Context) {
        viewModel.webView = webView
    }
}
