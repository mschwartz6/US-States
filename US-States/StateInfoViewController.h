//
//  StateInfoViewController.h
//  US-States
//
//  Created by alive on 10/31/17.
//  Copyright © 2017 Matthew Schwartz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateInfoViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) NSString *stateName;
@property (nonatomic,strong) IBOutlet UIWebView *myWebView;
@property (nonatomic,strong) UIColor *mainColor;
@end
