//
//  PSLoginViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 6/5/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSLoginViewController.h"
#import "QRCodeReader.h"
#import "QRCodeReaderViewController.h"
#import "UIColor+AppColor.h"
#import "UITextField+PaddingText.h"
#import "AppConstants.h"
#import "UIButton+Border.h"
#import <TTPLLibrary/NSString+Validation.h>
#import "NSAttributedString+StringWithImage.h"
#import "SignInApi.h"
#import "SignUpApi.h"

static NSString *const kHomeScreenViewSegueIdentifier = @"HomeScreenViewSegue";

@interface PSLoginViewController ()<QRCodeReaderDelegate> {
    QRCodeReaderViewController *vc;
}

@property (assign, nonatomic) NSInteger numberOfDigit;

@property (weak, nonatomic) IBOutlet UILabel *paySayTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *paySayTitle2Label;

@property (weak, nonatomic) IBOutlet UIButton *topSignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *topSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) IBOutlet UIButton *backToLoginButton;
@property (weak, nonatomic) IBOutlet UILabel *backToLoginLabel;

@property (weak, nonatomic) IBOutlet UIView *signUpSignInTopButtonsContainerView;
@property (weak, nonatomic) IBOutlet UIView *topSignUpUnderlineView;
@property (weak, nonatomic) IBOutlet UIView *topSignInUnderlineView;

@property (weak, nonatomic) IBOutlet UIView *signUpContainerView;
@property (weak, nonatomic) IBOutlet UIView *signInContainerView;
@property (weak, nonatomic) IBOutlet UIView *otpContainerView;

@property (weak, nonatomic) IBOutlet UITextField *signUpFullNameTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *signUpPhoneNoTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *signUpPasswordTxtFld;

@property (weak, nonatomic) IBOutlet UITextField *signInPhoneEmailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *signInPasswordTxtFld;

@property (weak, nonatomic) IBOutlet UITextField *otpTextField;

@property (weak, nonatomic) IBOutlet UIButton *otp1Btn;
@property (weak, nonatomic) IBOutlet UIButton *otp2Btn;
@property (weak, nonatomic) IBOutlet UIButton *otp3Btn;
@property (weak, nonatomic) IBOutlet UIButton *otp4Btn;

@property (weak, nonatomic) IBOutlet UITextView *resendTextView;
@property (weak, nonatomic) IBOutlet UITextView *changeNumberTextView;

@end

@implementation PSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topSignUpButtonClicked:nil];
    [self setUpQRCodeScanner];
    [self setUpViewElements];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)setUpViewElements {
    [self.signUpFullNameTxtFld setTextFieldPadding:5];
    [self.signUpPhoneNoTxtFld setTextFieldPadding:5];
    [self.signUpEmailTxtFld setTextFieldPadding:5];
    [self.signUpPasswordTxtFld setTextFieldPadding:5];
    [self.signInPhoneEmailTxtFld setTextFieldPadding:5];
    [self.signInPasswordTxtFld setTextFieldPadding:5];
    self.otpContainerView.hidden = YES;
    self.paySayTitle1Label.attributedText = [NSAttributedString getPaySayTextWithLeftImage:[UIImage imageNamed:@"launcher"] withName:NSLocalizedString(@"PAYSAY", nil)];
    self.paySayTitle2Label.attributedText = [NSAttributedString getPaySayTextWithLeftImage:[UIImage imageNamed:@"launcher"] withName:NSLocalizedString(@"PAYSAY", nil)];
    [self.signInButton setBackgroundColor:[UIColor appPrimaryBlueColorButton]];
    [self.signUpButton setBackgroundColor:[UIColor appPrimaryBlueColorButton]];
    [self.backToLoginButton setBackgroundColor:[UIColor appPrimaryBlueColorButton]];
}

- (void)setUpQRCodeScanner {
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // Or use blocks
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:NULL];
        });
    }];
}

- (IBAction)topSignUpButtonClicked:(id)sender {
    self.topSignInUnderlineView.backgroundColor = [UIColor midGrayColor];
    self.topSignUpUnderlineView.backgroundColor = [UIColor appPrimaryBlueColorButton];
    [self.topSignUpButton setTitleColor:[UIColor appPrimaryBlueColorButton] forState:UIControlStateNormal];
    [self.topSignInButton setTitleColor:[UIColor appGreyColor] forState:UIControlStateNormal];
    self.signUpContainerView.hidden = NO;
    self.signInContainerView.hidden = YES;
    [self.view endEditing:YES];
}

- (IBAction)topSignInButtonClicked:(id)sender {
    self.topSignUpUnderlineView.backgroundColor = [UIColor midGrayColor];
    self.topSignInUnderlineView.backgroundColor = [UIColor appPrimaryBlueColorButton];
    [self.topSignUpButton setTitleColor:[UIColor appGreyColor] forState:UIControlStateNormal];
    [self.topSignInButton setTitleColor:[UIColor appPrimaryBlueColorButton] forState:UIControlStateNormal];
    self.signUpContainerView.hidden = YES;
    self.signInContainerView.hidden = NO;
    [self.view endEditing:YES];
}

- (IBAction)signUpButtonClicked:(id)sender {
//    if (![self.signUpEmailTxtFld.text isValidEmail]) {
//        return;
//    }
//    if (![self.signInPhoneEmailTxtFld.text isValidMobileNumber]) {
//        return;
//    }
//    if (![self.signUpFullNameTxtFld.text isValidName]) {
//        return;
//    }
    [self setTextViewColors];
    self.otpContainerView.hidden = NO;
    [self.otpTextField becomeFirstResponder];
    
    __weak PSLoginViewController *weakSelf = self;
    SignUpApi *signUpApi = [SignUpApi new];
    signUpApi.username = self.signUpFullNameTxtFld.text;
    signUpApi.password = self.signUpPasswordTxtFld.text;
    signUpApi.email = self.signUpEmailTxtFld.text;
    signUpApi.phoneNumber = self.signUpPhoneNoTxtFld.text;
    [[APIManager sharedInstance]makeAPIRequestWithObject:signUpApi shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        if (!error) {
            
        }else{
        }
    }];
    
}

- (IBAction)forgotPasswordButtonClicked:(id)sender {
//    [self presentViewController:vc animated:YES completion:NULL];
    self.signInButton.hidden = YES;
    self.backToLoginButton.hidden = NO;
    self.backToLoginLabel.hidden = NO;
    self.signInPhoneEmailTxtFld.hidden = YES;
    self.signInPasswordTxtFld.hidden = YES;
    self.forgotPasswordButton.hidden = YES;
    self.signUpSignInTopButtonsContainerView.hidden = YES;
}

- (IBAction)loginButtonClicked:(id)sender {
    if ([self.signInPhoneEmailTxtFld.text isValidEmail]) {
        ;
    }
    __weak PSLoginViewController *weakSelf = self;
    SignInApi *signInApi = [SignInApi new];
    signInApi.username = self.signInPhoneEmailTxtFld.text;
    signInApi.password = self.signInPasswordTxtFld.text;
    signInApi.grantType = self.signInPasswordTxtFld.text;
    [[APIManager sharedInstance]makeAPIRequestWithObject:signInApi shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        if (!error) {

        }else{
        }
    }];

    
    [self performSegueWithIdentifier:kHomeScreenViewSegueIdentifier sender:self];
}

- (IBAction)verifyOTPButtonClicked:(id)sender {
    self.otpContainerView.hidden = YES;
    [self.view endEditing:YES];
}

- (IBAction)backToLoginButtonClicked:(id)sender {
    self.backToLoginButton.hidden = YES;
    self.backToLoginLabel.hidden = YES;
    self.signInPhoneEmailTxtFld.hidden = NO;
    self.signInPasswordTxtFld.hidden = NO;
    self.forgotPasswordButton.hidden = NO;
    self.signInButton.hidden = NO;
    self.signUpSignInTopButtonsContainerView.hidden = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([textView isEqual:self.resendTextView]) {
        NSLog(@"Resend clicked");
    }else if([textView isEqual:self.changeNumberTextView]){
        NSLog(@"Change number text View link clicked");
    }
    return YES;
}

#pragma mark - QRCodeReader Delegate Methods

- (void)setTextViewColors {
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:13.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [UIColor appGreyColor],  NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.resendTextView.text attributes:attrsDictionary];
    NSRange range = [self.resendTextView.text rangeOfString:@"Resend"];
    [string addAttribute: NSLinkAttributeName value: @"RangeLinkClicked" range: range];
    self.resendTextView.attributedText = string;
    self.resendTextView.textAlignment = NSTextAlignmentCenter;
    self.resendTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor appBlueColor]};
    
    string = [[NSMutableAttributedString alloc] initWithString:self.changeNumberTextView.text attributes:attrsDictionary];
    range = [self.changeNumberTextView.text rangeOfString:@"Change"];
    [string addAttribute: NSLinkAttributeName value: @"ChangeNumberClicked" range: range];
    self.changeNumberTextView.attributedText = string;
    self.changeNumberTextView.textAlignment = NSTextAlignmentCenter;
    self.changeNumberTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor appBlueColor]};
    
    [self.otp1Btn addBottomBorderWithColor:[UIColor midGrayColor] andWidth:3];
    [self.otp2Btn addBottomBorderWithColor:[UIColor midGrayColor] andWidth:3];
    [self.otp3Btn addBottomBorderWithColor:[UIColor midGrayColor] andWidth:3];
    [self.otp4Btn addBottomBorderWithColor:[UIColor midGrayColor] andWidth:3];
    self.otpTextField.text = @"";
    [self.otpTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.numberOfDigit = 4.0f;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [self updateOTP];
    if (textField.text.length >= self.numberOfDigit) {
        [self.view endEditing:YES];
    }
}

- (void)updateOTP {
    NSString *numberText = self.otpTextField.text;
    NSInteger minLength = MIN(numberText.length, self.numberOfDigit);
    for(int i=0; i<self.numberOfDigit; i++){
        UIButton *otpButton;
        NSString *digit;
        switch (i) {
            case 0:
                if (i<minLength) {
                    digit = [self.otpTextField.text substringWithRange:NSMakeRange(i, 1)];
                    [self.otp1Btn setTitle:digit forState:UIControlStateNormal];
                }
                otpButton = self.otp1Btn;
                break;
            case 1:
                if (i<minLength) {
                    digit = [self.otpTextField.text substringWithRange:NSMakeRange(i, 1)];
                    [self.otp2Btn setTitle:digit forState:UIControlStateNormal];
                }
                otpButton = self.otp2Btn;
                break;
            case 2:
                if (i<minLength) {
                    digit = [self.otpTextField.text substringWithRange:NSMakeRange(i, 1)];
                    [self.otp3Btn setTitle:digit forState:UIControlStateNormal];
                }
                otpButton = self.otp3Btn;
                break;
            case 3:
                if (i<minLength) {
                    digit = [self.otpTextField.text substringWithRange:NSMakeRange(i, 1)];
                    [self.otp4Btn setTitle:digit forState:UIControlStateNormal];
                }
                otpButton = self.otp4Btn;
                break;
                
            default:
                break;
        }
        if (i>=minLength) {
            [otpButton setTitle:@"" forState:UIControlStateNormal];
        }
    }
}

- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];    //  return 0;
    return [emailTest evaluateWithObject:email];
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
