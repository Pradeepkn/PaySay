//
//  PSPayMerchantViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/30/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSPayMerchantViewController.h"
#import "QRCodeReaderViewController.h"
#import "PSAppUtilityClass.h"
#import "CreateMerchatPayCodeApi.h"
#import "PaySayAlertViewController.h"
#import "UIColor+AppColor.h"

@interface PSPayMerchantViewController ()<QRCodeReaderDelegate>{
    QRCodeReaderViewController *vc;
}
@property (weak, nonatomic) IBOutlet UIButton *qrCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *merchantCodeTxtField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *amountButton;
@property (weak, nonatomic) IBOutlet UITextField *billNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *proceedToPayButton;

@end

@implementation PSPayMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.text = [PSAppUtilityClass getUserEmail];
    self.title = NSLocalizedString(@"PAY MERCHANT", nil);
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

- (IBAction)qrCodeButtonClicked:(id)sender {
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // Or use blocks
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
        NSArray *qrCodeElements = [resultAsString componentsSeparatedByString:@"/"];
        NSString *finalString = [qrCodeElements objectAtIndex:qrCodeElements.count - 1];
        if ([finalString isEqualToString:@""] || finalString.length < 1) {
            finalString = [qrCodeElements objectAtIndex:qrCodeElements.count - 2];
        }
        self.merchantCodeTxtField.text = finalString;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:NULL];
        });
    }];
    [self presentViewController:vc animated:YES completion:^{
        ;
    }];
}

- (IBAction)amountButtonClicked:(id)sender {
    
}

- (IBAction)phoneCodeButtonClicked:(id)sender {
    
}

- (IBAction)proceedToPayButtonClicked:(id)sender {
    __weak PSPayMerchantViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    CreateMerchatPayCodeApi *createMerchatPayCodeApiObject = [CreateMerchatPayCodeApi new];
    createMerchatPayCodeApiObject.amount = self.amountTextField.text;
    createMerchatPayCodeApiObject.payCode = self.merchantCodeTxtField.text;
    createMerchatPayCodeApiObject.contact = self.phoneNumberTextField.text;
    createMerchatPayCodeApiObject.email = self.emailTextField.text;
    createMerchatPayCodeApiObject.billNumber = self.billNumberTextField.text;
    
    [[APIManager sharedInstance]makeAPIRequestWithObject:createMerchatPayCodeApiObject shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
        }else{
            [PSAppUtilityClass showErrorMessage:NSLocalizedString(@"Please try again later", nil)];
        }
    }];
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
