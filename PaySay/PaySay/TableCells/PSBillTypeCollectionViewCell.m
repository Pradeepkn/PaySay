//
//  PSBillTypeCollectionViewCell.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/1/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSBillTypeCollectionViewCell.h"

@implementation PSBillTypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = self.billTypeLabel.textColor.CGColor;
}

@end
