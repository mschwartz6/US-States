//
//  StateInfoViewController.m
//  US-States
//
//  Created by alive on 10/31/17.
//  Copyright © 2017 Matthew Schwartz. All rights reserved.
//

#import "StateInfoViewController.h"

@interface StateInfoViewController ()
{
    NSTimer *timer;
    int counter;
}
@property(nonatomic,strong)IBOutlet UILabel * titleLabel;
@property(nonatomic,strong)IBOutlet UIButton *backButton;
@end





@implementation StateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = 7;
    self.titleLabel.text = @"Loading more information...";
    UIColor *backColor = self.mainColor;
    self.view.backgroundColor = backColor;
    self.titleLabel.backgroundColor = backColor;
    self.backButton.backgroundColor = backColor;
    self.myWebView.backgroundColor = backColor;
    
    NSString *urlBase = @"https://en.m.wikipedia.org/wiki/";
    //Concatenate URL
    NSMutableString *urlComplete = [[NSMutableString alloc]initWithFormat:@"%@%@",urlBase,self.stateName];
    
    NSURL *url = [NSURL URLWithString:urlComplete];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //Initiate GET
    [self.myWebView loadRequest:urlRequest];
    //Create timer to display placeholder text for certain amount of time(int counter)
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCounter) userInfo:nil repeats:YES];
    //Set it back for label
    if ([self.stateName isEqualToString:@"Georgia_(US_state)"])
    {
        self.stateName = @"Georgia";
    }
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //Weird glitch for compatibility reasons with old browsers
    //Set body margin and padding to '0'
    NSString *pad = @"document.body.style.margin='0';document.body.style.padding='0'";
    [webView stringByEvaluatingJavaScriptFromString:pad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startCounter
{
    counter -=1;
    
    if (counter == 0)
    {
        
        self.titleLabel.text = [NSString stringWithFormat:@"More information about %@",self.stateName];
        [timer invalidate];
    }
}

@end
