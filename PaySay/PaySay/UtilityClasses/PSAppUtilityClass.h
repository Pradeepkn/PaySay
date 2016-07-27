//
//  PSAppUtilityClass.h
//  PaySay
//
//  Created by Pradeep Narendra on 7/27/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLMultiColorLoader;

@interface PSAppUtilityClass : NSObject

@property (strong, nonatomic)  BLMultiColorLoader *multiColorLoader;

+ (BLMultiColorLoader *)getMultiColorLoader;

+ (void)showLoaderOnView:(UIView *)view;

+ (void)hideLoaderFromView:(UIView *)view;

@end
