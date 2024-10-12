//
//  WebView.h
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

#ifndef WebView_h
#define WebView_h

#import <UIKit/UIKit.h>
#import "WebViewDelegate.h"

@interface WebView: UIView

@property(weak, nullable) id<WebViewDelegate> delegate;

- (void)loadByURLRequest:(NSURLRequest * _Nonnull)request;
- (void)reload;
- (nullable NSString *)webViewStringByEvaluatingJavaScriptFromString:(NSString * _Nonnull)string NS_SWIFT_NAME(stringByEvaluatingJavaScript(from:));

@end

#endif /* WebView_h */
