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

#define CLIENT_KEY @"CRDNwxmwHj688CuVjLEcq7ZudupVUIbke2Jflda7"
#define CLIENT_SECRET @"rbkopL6SLTPbmoEAViDglnwPQdVv4aC62UC6vxC16PiA4HIT5wY9nfgttRSiZgVEOZY7zfxfUk1tLNATq3i9Itbmuwb7sHK8gBC5epLxNqCIju6zYE6eS4MEFAbCZGjc"

static NSString *const kUsernameKey = @"username";
static NSString *const kPasswordKey = @"password";
static NSString *const kGrantTypeKey = @"grant_type";
static NSString *const kClientIdKey = @"client_id";
static NSString *const kClientSecretKey = @"client_secret";


static NSString *const kPhoneNumberKey = @"phone_number";
static NSString *const kEmailKey = @"email";
static NSString *const kNameKey = @"name";

static NSString *const kRegistraionId = @"registration_id";

static NSString *const kOtp = @"otp";

static NSString *const kAmountKey = @"amount";
static NSString *const kBillNumberKey = @"bill_number";
static NSString *const kBasketKey = @"basket";
static NSString *const kUseRewardsKey = @"use_rewards";

static NSString *const kService = @"service";
static NSString *const kRechargeNumber = @"recharge_number";
static NSString *const kOperatorCode = @"operator_code";



#endif /* AppConstants_h */
