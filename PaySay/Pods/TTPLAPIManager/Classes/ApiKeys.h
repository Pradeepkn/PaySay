//
//  ApiKeys.h
//
//
//  Created by Subramanian on 11/10/14.
//  Copyright (c) 2014 Tarento Technologies Pvt Ltd. All rights reserved.
//

#ifndef ApiKeys_h
#define ApiKeys_h

#warning Update the API related configuration details & Disable this warning flag.

#pragma mark - Configuration -
// URLs
static NSString *const APIStaginUrl = @"https://sandbox.letspool.co";
static NSString *const APIProductionUrl = @"https://paysay.me";

// Change the flag based on server.
static BOOL ShouldUseProductionUrl = NO;

#pragma mark - Defulte Values -
// API Request Type
static NSString *const APIGet = @"GET";
static NSString *const APIPost = @"POST";
static NSString *const APIDelete = @"DELETE";

// Timeout interval
static float APITimeOut = 10.0f;

// API Status Code
static NSInteger APIStatusCodeSuccess = 200;

#endif
