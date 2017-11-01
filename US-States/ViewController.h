//
//  ViewController.h
//  US-States
//
//  Created by alive on 10/31/17.
//  Copyright © 2017 Matthew Schwartz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateInfoViewController.h"
@interface ViewController : UIViewController
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@end

