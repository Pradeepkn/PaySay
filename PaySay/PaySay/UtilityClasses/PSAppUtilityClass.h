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

+ (void)showLoaderOnView:(UIView *)view;

+ (void)hideLoaderFromView:(UIView *)view;

+ (void)storeUserName:(NSString *)userName;

+ (void)storeUserEmail:(NSString *)userEmail;

+ (void)storeUserPhoneNumber:(NSString*)userPhoneNumber;

+ (NSString *)getUserName;

+ (NSString *)getUserEmail;

+ (NSString *)getUserPhoneNUmber;

+ (void)showErrorMessage:(NSString *)message;

@end
