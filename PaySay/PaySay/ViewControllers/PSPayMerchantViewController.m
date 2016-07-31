//
//  PSPayMerchantViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/30/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSPayMerchantViewController.h"
#import "QRCodeReaderViewController.h"

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
    // Do any additional setup after loading the view.
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
        self.merchantCodeTxtField.text = resultAsString;
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
