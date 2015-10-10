//
//  JZTabbarJXViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZTabbarJXViewController.h"

@interface JZTabbarJXViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation JZTabbarJXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = @"http://t10.nuomi.com/webapp/na/topten?from=fr_na_t10tab&sizeLimit=8&version=2&needstorecard=1&areaId=100010000&location=39.989430,116.324470&bn_aid=ios&bn_v=5.13.0&bn_chn=com_dot_apple";
    
    self.webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initViews{
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screen_width/2-15, screen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}

#pragma mark - **************** UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载webview");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载webview完成");
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.title = theTitle;
    
    [_activityView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载webview失败");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.title = theTitle;
    NSLog(@"shouldStartLoadWithRequest:   %@",theTitle);
    
    [_activityView startAnimating];
    return YES;
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
