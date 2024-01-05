//
//  WebViewDelegate.h
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

#ifndef WebViewDelegate_h
#define WebViewDelegate_h

@class WebView;

@protocol WebViewDelegate <NSObject>

@optional
- (BOOL)webView:(WebView * _Nonnull)webView shouldStartLoadWithRequest:(NSURLRequest * _Nullable)request navigationType:(NSInteger)navigationType;
- (void)webViewDidStartLoad:(WebView * _Nonnull)webView;
- (void)webViewDidFinishLoad:(WebView * _Nonnull)webView;
- (void)webView:(WebView * _Nonnull)webView didFailLoadWithError:(NSError * _Nonnull)error;
@end


#endif /* WebViewDelegate_h */
