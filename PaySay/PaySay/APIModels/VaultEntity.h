//
//  VaultEntity.h
//  PaySay
//
//  Created by Pradeep Narendra on 6/28/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VaultEntity : NSObject

@property (nonatomic, assign) NSInteger vaultId;
@property (nonatomic, strong) NSString *vaultType;
@property (nonatomic, strong) NSString *vaultValue;
@property (nonatomic, assign) NSInteger conversionRate;
@property (nonatomic, assign) NSInteger minimumRedeemValue;

@end
