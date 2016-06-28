//
//  AppConstants.h
//  PaySay
//
//  Created by Pradeep Narendra on 6/5/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

/******** access token key *********/
#define ACCESS_TOKEN @"accessToken"

#define kDeviceToken @"kDevicePushToken"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define OS_VERSION_EQUALS_OR_AFTER(version) [[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][0] intValue] >= version

#define OS_VERSION_BEFORE(version) [[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][0] intValue] < version

static NSString *const kUsernameKey = @"username";
static NSString *const kPasswordKey = @"password";
static NSString *const kGrantTypeKey = @"grant_type";
static NSString *const kClientIdKey = @"client_id";
static NSString *const kClientSecretKey = @"client_secret";


static NSString *const kPhoneNumberKey = @"phone_number";
static NSString *const kEmailKey = @"email";
static NSString *const kNameKey = @"name";

#endif /* AppConstants_h */
