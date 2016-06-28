//
//  UserEntity.h
//  PaySay
//
//  Created by Pradeep Narendra on 6/28/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSMutableArray *vaultsArray;

@end
