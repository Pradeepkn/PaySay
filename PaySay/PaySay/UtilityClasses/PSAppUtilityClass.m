//
//  PSAppUtilityClass.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/27/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSAppUtilityClass.h"
#import "BLMultiColorLoader.h"

@implementation PSAppUtilityClass

#pragma mark -
#pragma mark - PSAppUtilityClass Shared Instance
+ (instancetype)sharedInstance {
    static PSAppUtilityClass *appUtilitySharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appUtilitySharedInstance = [[super alloc] initUniqueInstance];
        /// Please reset the flag here is you are not using JSON Request
        /// Serializer
        appUtilitySharedInstance.multiColorLoader = [[BLMultiColorLoader alloc] initWithFrame:CGRectMake(0,0,30,30)];
        // Customize the line width
        appUtilitySharedInstance.multiColorLoader.lineWidth = 2.0;
        
        // Pass the custom colors array
        appUtilitySharedInstance.multiColorLoader.colorArray = [NSArray arrayWithObjects:[UIColor redColor],
                                       [UIColor purpleColor],
                                       [UIColor orangeColor],
                                       [UIColor blueColor], nil];
        [appUtilitySharedInstance.multiColorLoader setHidden:YES];
    });
    return appUtilitySharedInstance;
}

- (instancetype)initUniqueInstance {
    return [super init];
}

+ (void)showLoaderOnView:(UIView *)view {
    [view addSubview:[PSAppUtilityClass sharedInstance].multiColorLoader];
    [PSAppUtilityClass sharedInstance].multiColorLoader.center = view.center;
    [[PSAppUtilityClass sharedInstance].multiColorLoader startAnimation];
    [[PSAppUtilityClass sharedInstance].multiColorLoader setHidden:NO];
}

+ (void)hideLoaderFromView:(UIView *)view {
    [[PSAppUtilityClass sharedInstance].multiColorLoader stopAnimationAfter:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[PSAppUtilityClass sharedInstance].multiColorLoader setHidden:YES];
        [view willRemoveSubview:[PSAppUtilityClass sharedInstance].multiColorLoader];
    });
}

@end
