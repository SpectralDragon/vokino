//
//  WebView.m
//  VoKino
//
//  Created by v.prusakov on 1/4/24.
//

#import <UIKit/UIKit.h>
#import "WebView.h"

@interface WebView ()

@property id webview;
@property CGPoint lastTouchLocation;

@end

@implementation WebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWebView];
    }
    return self;
}

-(void)loadByURLRequest:(NSURLRequest *)request {
    [_webview loadRequest:request];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIScrollView *scrollView = [self.webview scrollView];
    scrollView.frame = self.bounds;
    scrollView.clipsToBounds = NO;
    [scrollView setNeedsLayout];
    [scrollView layoutIfNeeded];
    
    [_webview setFrame:self.frame];
    
    scrollView.panGestureRecognizer.allowedTouchTypes = @[ @(UITouchTypeIndirect) ];
    scrollView.scrollEnabled = NO;
    
    [self.webview setUserInteractionEnabled:NO];
}

-(void)initWebView {
    self.webview = [[NSClassFromString(@"UIWebView") alloc] init];
    [self.webview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.webview setClipsToBounds:NO];
    
    [self addSubview: self.webview];

    [self.webview setFrame:self.bounds];
    [self.webview setDelegate:self];
    [self.webview setLayoutMargins:UIEdgeInsetsZero];
    
    UIScrollView *scrollView = [self.webview scrollView];
    scrollView.backgroundColor = [UIColor blackColor];
    [scrollView setLayoutMargins:UIEdgeInsetsZero];
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    scrollView.contentOffset = CGPointZero;
    scrollView.contentInset = UIEdgeInsetsZero;
}

#pragma mark RemoteControl

- (nullable NSString *)webViewStringByEvaluatingJavaScriptFromString:(NSString *)string {
    return [_webview stringByEvaluatingJavaScriptFromString:string];
}

#pragma mark UIWebView

- (BOOL)webView:(id *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType {
    if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [_delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(id *)webView {
    if ([_delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_delegate webViewDidStartLoad:self];
    }
}

- (void)webViewDidFinishLoad:(id *)webView {
    if ([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_delegate webViewDidFinishLoad:self];
    }
}

- (void)webView:(id *)webView didFailLoadWithError:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_delegate webView:self didFailLoadWithError:error];
    }
}


@end
