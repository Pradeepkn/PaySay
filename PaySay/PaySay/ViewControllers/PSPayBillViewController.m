//
//  PSPayBillViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/1/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSPayBillViewController.h"
#import "PSBillTypeCollectionViewCell.h"
#import "PSAppUtilityClass.h"

static NSString *const kBillTypeCellIdentifier = @"BillTypeCellIdentifier";
static NSString *const kPayBillSegueIdentifier  = @"PayBillSegue";

@interface PSPayBillViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *billTypeCollectionView;

@end

@implementation PSPayBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = 4;
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(((self.billTypeCollectionView.bounds.size.width-0.1) / 4), (self.billTypeCollectionView.bounds.size.width - 0.1) / 4);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PSBillTypeCollectionViewCell *cell = (PSBillTypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kBillTypeCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.billTypeImageView.image = [UIImage imageNamed:@"mobile_big"];
            cell.billTypeLabel.text = @"Mobile";
            break;
        case 1:
            cell.billTypeImageView.image = [UIImage imageNamed:@"datacard_big"];
            cell.billTypeLabel.text = @"Datacard";
            break;
        case 2:
            cell.billTypeImageView.image = [UIImage imageNamed:@"dth_big"];
            cell.billTypeLabel.text = @"DTH";
            break;
        case 3:
            cell.billTypeImageView.image = [UIImage imageNamed:@"electricity_big"];
            cell.billTypeLabel.text = @"Electricity";
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark - Collection View deleagete

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kPayBillSegueIdentifier sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
