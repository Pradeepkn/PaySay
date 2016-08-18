//
//  PSLoginViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 6/5/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSLoginViewController.h"
#import "SignInApi.h"
#import "SignUpApi.h"
#import "UserEntity.h"
#import "VaultEntity.h"
#import "AppConstants.h"
#import "VerifyTokenApi.h"
#import "QRCodeReader.h"
#import "UIButton+Border.h"
#import "PSAppUtilityClass.h"
#import "UIColor+AppColor.h"
#import "ForgotPasswordApi.h"
#import "UITextField+PaddingText.h"
#import <TTPLLibrary/NSString+Validation.h>
#import "NSAttributedString+StringWithImage.h"
#import "PaySayAlertViewController.h"

static NSString *const kHomeScreenViewSegueIdentifier = @"HomeScreenViewSegue";

@interface PSLoginViewController () {
    NSString *userEmailOrMobileName;
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
    [self setUpViewElements];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUsernameKey] && [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey]) {
        [self topSignInButtonClicked:nil];
        self.signInPhoneEmailTxtFld.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUsernameKey];
        self.signInPasswordTxtFld.text = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey];
        [self verifyToken:[[NSUserDefaults standardUserDefaults] objectForKey:kUsernameKey] andPassword:[[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey]];
    }
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
    [PSAppUtilityClass showLoaderOnView:self.view];

    __weak PSLoginViewController *weakSelf = self;
    SignUpApi *signUpApi = [SignUpApi new];
    signUpApi.username = self.signUpFullNameTxtFld.text;
    signUpApi.password = self.signUpPasswordTxtFld.text;
    signUpApi.email = self.signUpEmailTxtFld.text;
    signUpApi.phoneNumber = self.signUpPhoneNoTxtFld.text;
    [[APIManager sharedInstance]makeAPIRequestWithObject:signUpApi shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        NSLog(@"Response = %@", responseDictionary);
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
            userEmailOrMobileName = weakSelf.signUpPhoneNoTxtFld.text;
            weakSelf.otpContainerView.hidden = NO;
            [weakSelf.otpTextField becomeFirstResponder];
        }else{
            [PSAppUtilityClass showErrorMessage:NSLocalizedString(@"Please try again later", nil)];
        }
    }];
}

- (void)verifyToken:(NSString *)userName andPassword:(NSString *)password {
    __weak PSLoginViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    VerifyTokenApi *verifyTokenApi = [VerifyTokenApi new];
    verifyTokenApi.username = userName;
    verifyTokenApi.password = password;
    self.otpTextField.text = @"";

    [[APIManager sharedInstance]makeAPIRequestWithObject:verifyTokenApi shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
            if (self.signInPhoneEmailTxtFld.text.length) {
                [PSAppUtilityClass storeUserEmail:self.signInPhoneEmailTxtFld.text];
                [[NSUserDefaults standardUserDefaults] setObject:self.signInPhoneEmailTxtFld.text forKey:kUsernameKey];
                [[NSUserDefaults standardUserDefaults] setObject:self.signInPasswordTxtFld.text forKey:kPasswordKey];
            }else{
                [PSAppUtilityClass storeUserEmail:self.signUpEmailTxtFld.text];
                [[NSUserDefaults standardUserDefaults] setObject:self.signUpEmailTxtFld.text forKey:kUsernameKey];
                [[NSUserDefaults standardUserDefaults] setObject:self.signUpPasswordTxtFld.text forKey:kPasswordKey];
            }
            [self performSegueWithIdentifier:kHomeScreenViewSegueIdentifier sender:nil];
        }else{
            [PSAppUtilityClass showErrorMessage:NSLocalizedString(@"Please try again later", nil)];
        }
    }];
}

- (IBAction)forgotPasswordButtonClicked:(id)sender {
    __weak PSLoginViewController *weakSelf = self;
    [PSAppUtilityClass showLoaderOnView:self.view];
    ForgotPasswordApi *forgotPasswordApi = [ForgotPasswordApi new];
    forgotPasswordApi.userName = self.signInPhoneEmailTxtFld.text;
    [[APIManager sharedInstance]makeAPIRequestWithObject:forgotPasswordApi shouldAddOAuthHeader:NO andCompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
        [PSAppUtilityClass hideLoaderFromView:weakSelf.view];
        if (!error) {
            userEmailOrMobileName = weakSelf.signInPhoneEmailTxtFld.text;
            [self setTextViewColors];
            self.signInContainerView.hidden = YES;
            weakSelf.otpContainerView.hidden = NO;
            [weakSelf.otpTextField becomeFirstResponder];
        }else{
            self.signInButton.hidden = YES;
            self.backToLoginButton.hidden = NO;
            self.backToLoginLabel.hidden = NO;
            self.signInPhoneEmailTxtFld.hidden = YES;
            self.signInPasswordTxtFld.hidden = YES;
            self.forgotPasswordButton.hidden = YES;
            self.signUpSignInTopButtonsContainerView.hidden = YES;
        }
    }];
}

- (IBAction)loginButtonClicked:(id)sender {
    if ([self.signInPhoneEmailTxtFld.text isValidEmail]) {
        ;
    }
    [self verifyToken:self.signInPhoneEmailTxtFld.text andPassword:self.signInPasswordTxtFld.text];
}

- (IBAction)verifyOTPButtonClicked:(id)sender {
    self.otpContainerView.hidden = YES;
    [self.view endEditing:YES];
    [self verifyToken:userEmailOrMobileName andPassword:self.otpTextField.text];
}

- (IBAction)backToLoginButtonClicked:(id)sender {
    [self showLoginScreen];
}

- (void)showLoginScreen {
    self.backToLoginButton.hidden = YES;
    self.backToLoginLabel.hidden = YES;
    self.signInPhoneEmailTxtFld.hidden = NO;
    self.signInPasswordTxtFld.hidden = NO;
    self.forgotPasswordButton.hidden = NO;
    self.signInButton.hidden = NO;
    self.otpContainerView.hidden = YES;
    self.signInContainerView.hidden = NO;
    self.signUpSignInTopButtonsContainerView.hidden = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([textView isEqual:self.resendTextView]) {
        NSLog(@"Resend clicked");
        [self forgotPasswordButtonClicked:nil];
    }else if([textView isEqual:self.changeNumberTextView]){
        NSLog(@"Change number text View link clicked");
        [self backToLoginButtonClicked:nil];
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
