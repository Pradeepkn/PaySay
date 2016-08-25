//
//  MerchantPaymentViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/23/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "MerchantPaymentViewController.h"
#import <WebKit/WebKit.h>
#import "NSMutableURLRequest+IgnoreSSL.h"
#import "PSAppUtilityClass.h"
#import "WebViewJavascriptBridge.h"

#define CLIENT_KEY @"CRDNwxmwHj688CuVjLEcq7ZudupVUIbke2Jflda7"

@interface MerchantPaymentViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) WebViewJavascriptBridge* bridge;

@end

@implementation MerchantPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadWebView];
    
    [self.bridge registerHandler:@"onPaymentFail" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    [self.bridge registerHandler:@"pgResponse" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    [self.bridge callHandler:@"onPaymentFail" data:nil responseCallback:^(id responseData) {
        ;
    }];
}

- (void)loadWebView {
    [PSAppUtilityClass showLoaderOnView:self.view];

    NSURL *nsurl = [NSURL URLWithString:self.merchantUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    NSString *tokenKey;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AccessTokenKey"]) {
        tokenKey = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AccessTokenKey"]];
    }
    [request setValue:[NSString stringWithFormat:@"%@", tokenKey] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"iOS" forHTTPHeaderField:@"x-cheripo-device-os"];
    [request setValue:[self getUniqueDeviceIdentifierAsString] forHTTPHeaderField:@"x-cheripo-device-id"];
    [request setValue:@"1" forHTTPHeaderField:@"x-cheripo-package-version"];
    [request setValue:CLIENT_KEY forHTTPHeaderField:@"x-cheripo-client-id"];
    [request setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"x-cheripo-device-hardware"];
    [request setValue:@"Apple" forHTTPHeaderField:@"x-cheripo-device-manufacturer"];
    [request setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"x-cheripo-device-version"];
    [NSMutableURLRequest setAllowsAnyHTTPSCertificate:YES forHost:self.merchantUrl];
    
    [self.webView loadRequest:request];
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return strApplicationUUID;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [PSAppUtilityClass showLoaderOnView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [PSAppUtilityClass hideLoaderFromView:self.view];
    NSString  *html = [self.webView stringByEvaluatingJavaScriptFromString: @"document.documentElement.outerHTML"]; //document.body.innerHTMLA
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [PSAppUtilityClass hideLoaderFromView:self.view];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
