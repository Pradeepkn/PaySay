//
//  OperatorsApi.h
//  PaySay
//
//  Created by Pradeep Narendra on 8/6/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <TTPLAPIManager/TTPLAPIManager.h>

@interface OperatorsApi : APIBase

@property (nonatomic, assign) NSInteger filter;

@property (nonatomic, strong) NSMutableArray *operatorsObjects;

@end
