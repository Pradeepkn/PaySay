//
//  PSOperatorsViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/7/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSOperatorsViewController.h"
#import "UITextField+PaddingText.h"
#import "PSAppUtilityClass.h"
#import "OperatorsApi.h"
#import "Operators.h"
#import "UIcolor+AppColor.h"
#import "PaySayAlertViewController.h"

@interface PSOperatorsViewController () {
}

@property (weak, nonatomic) IBOutlet UIView *operatorsContainerView;
@property (weak, nonatomic) IBOutlet UITextField *operatorTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *operatorSymbol;
@property (weak, nonatomic) IBOutlet UIButton *mobileSymbol;
@property (weak, nonatomic) IBOutlet UIButton *amountSymbol;

@property (nonatomic, strong) NSMutableArray *operatorsArray;

@end

@implementation PSOperatorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.operatorTextField setLeftPadding:5];
    [self.mobileTextField setLeftPadding:5];
    [self.amountTextField setLeftPadding:5];
    [self fetchListOfOperators];
}

- (IBAction)chooseOperatorButtonClicked:(id)sender {
    [self showOperatorsList];
}

- (IBAction)rechargeButtonClicked:(id)sender {
}

- (void)fetchListOfOperators {
    self.operatorsArray = [[NSMutableArray alloc] init];
    __weak PSOperatorsViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    OperatorsApi *operatorsApiObject = [OperatorsApi new];
    [[APIManager sharedInstance]makeAPIRequestWithObject:operatorsApiObject shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
            for (Operators *operatorObject in operatorsApiObject.operatorsObjects) {
                [self.operatorsArray addObject:operatorObject.operatorName];
            }
        }else{
        }
    }];
}

- (void)showOperatorsList {
    PaySayAlertModel *alertModel = [[PaySayAlertModel alloc] init];
    alertModel.alertTableEntries = [NSMutableArray arrayWithArray:(NSArray *)self.operatorsArray];
    alertModel.alertCellTitleColor = [UIColor appBlueColor];
    alertModel.alertCellTitleLabelFont = self.operatorTextField.font;
    alertModel.shouldDisplayPreviousSelectedIndex = YES;
    alertModel.kAlertTableCellHeight = 40.0f;
    alertModel.kAlertPreviousSelectedIndex = 0;
    alertModel.isTableViewScrollEnabled = YES;
    __weak PSOperatorsViewController *weakSelf = self;
    if (self.operatorsArray.count > 0) {
        [[PaySayAlertViewController sharedInstance] showAlertTableViewOn:[UIApplication sharedApplication].keyWindow withModel:alertModel onCompletion:^(NSIndexPath *sender) {
            NSString *selectedOperator = [self.operatorsArray objectAtIndex:sender.row];
            self.operatorTextField.text = selectedOperator;
            NSLog(@"Selected operator = %@", selectedOperator);
            return;
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.operatorTextField]) {
        [self showOperatorsList];
        [textField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
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
