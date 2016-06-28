//
//  MyExpensesTableViewCell.h
//  PaySay
//
//  Created by Pradeep Narendra on 6/19/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyExpensesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *thumbnailLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
