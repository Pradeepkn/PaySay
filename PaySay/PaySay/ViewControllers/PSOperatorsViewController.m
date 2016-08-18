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
#import "RechargePaymentApi.h"

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
@property (nonatomic, strong) NSMutableArray *operatorNamesArray;
@property (nonatomic, strong) Operators *selectedOperator;

@end

@implementation PSOperatorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.operatorTextField setLeftPadding:5];
    [self.mobileTextField setLeftPadding:5];
    [self.amountTextField setLeftPadding:5];
    [self fetchListOfOperators];
    [self setIconButton];
}

- (void)setIconButton {
    UIButton *settingsView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [settingsView addTarget:self action:@selector(onBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsView];
    [self.navigationItem setLeftBarButtonItem:settingsButton];
    self.title = @"PAYSAY";
}

- (void)onBackButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseOperatorButtonClicked:(id)sender {
    [self showOperatorsList];
}

- (IBAction)rechargeButtonClicked:(id)sender {
    if (self.operatorTextField.text.length <= 0) {
        [PSAppUtilityClass showErrorMessage:@"Please choose the operator"];
        return;
    }else if (self.mobileTextField.text.length <= 0) {
        [PSAppUtilityClass showErrorMessage:@"Please enter operator number to pay bill"];
        return;
    }else if(self.amountTextField.text.length <= 0) {
        [PSAppUtilityClass showErrorMessage:@"Please enter the valid amount to pay bill"];
        return;
    }
    [self.view endEditing:YES];
    __weak PSOperatorsViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    RechargePaymentApi *rechargePaymentApiObject = [RechargePaymentApi new];
    rechargePaymentApiObject.amount = [NSNumber numberWithDouble:self.amountTextField.text.doubleValue];
    rechargePaymentApiObject.email = [PSAppUtilityClass getUserEmail];
    rechargePaymentApiObject.service = self.selectedOperator.operatorsService;
    rechargePaymentApiObject.rechargeNumber = self.mobileTextField.text;
    rechargePaymentApiObject.operatorCode = self.selectedOperator.operatorCode;
    rechargePaymentApiObject.useRewards = [NSNumber numberWithBool:NO];
    [[APIManager sharedInstance]makeAPIRequestWithObject:rechargePaymentApiObject shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
        }else{
            [PSAppUtilityClass showErrorMessage:NSLocalizedString(@"Please try again later", nil)];
        }
    }];
}

- (void)fetchListOfOperators {
    self.operatorsArray = [[NSMutableArray alloc] init];
    self.operatorNamesArray = [[NSMutableArray alloc] init];
    __weak PSOperatorsViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    OperatorsApi *operatorsApiObject = [OperatorsApi new];
    [[APIManager sharedInstance]makeAPIRequestWithObject:operatorsApiObject shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
            for (Operators *operatorObject in operatorsApiObject.operatorsObjects) {
                [self.operatorsArray addObject:operatorObject];
                [self.operatorNamesArray addObject:operatorObject.operatorName];
            }
        }else{
            [PSAppUtilityClass showErrorMessage:NSLocalizedString(@"Please try again later", nil)];
        }
    }];
}

- (void)showOperatorsList {
    PaySayAlertModel *alertModel = [[PaySayAlertModel alloc] init];
    alertModel.alertTableEntries = [NSMutableArray arrayWithArray:(NSArray *)self.operatorNamesArray];
    alertModel.alertCellTitleColor = [UIColor appBlueColor];
    alertModel.alertCellTitleLabelFont = self.operatorTextField.font;
    alertModel.shouldDisplayPreviousSelectedIndex = YES;
    alertModel.kAlertTableCellHeight = 40.0f;
    alertModel.kAlertPreviousSelectedIndex = 0;
    alertModel.isTableViewScrollEnabled = YES;
    __weak PSOperatorsViewController *weakSelf = self;
    if (self.operatorsArray.count > 0) {
        [[PaySayAlertViewController sharedInstance] showAlertTableViewOn:[UIApplication sharedApplication].keyWindow withModel:alertModel onCompletion:^(NSIndexPath *sender) {
            self.selectedOperator = [self.operatorsArray objectAtIndex:sender.row];
            self.operatorTextField.text = self.selectedOperator.operatorName;
            NSLog(@"Selected operator = %@", self.selectedOperator.operatorCode);
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
