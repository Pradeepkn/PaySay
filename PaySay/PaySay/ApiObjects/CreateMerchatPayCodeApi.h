//
//  CreateMerchatPayCodeApi.h
//  PaySay
//
//  Created by Pradeep Narendra on 7/31/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <TTPLAPIManager/TTPLAPIManager.h>

@interface CreateMerchatPayCodeApi : APIBase

@property (nonatomic, strong) NSString *payCode;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *billNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *basket;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) Boolean useRewards;

@end
