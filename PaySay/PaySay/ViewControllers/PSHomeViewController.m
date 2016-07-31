//
//  PSHomeViewController.m
//  PaySay
//
//  Created by Pradeep Narendra on 6/18/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "PSHomeViewController.h"
#import "MyExpensesTableViewCell.h"
#import "UIColor+AppColor.h"
#import "AppConstants.h"

static NSString *kMyExpensesCellIdentifier = @"MyExpensesCellIdentifier";
static NSString *kPayMerchantSegueIdentifier = @"PayMerchantSegue";
static NSString *kPayBillSegueIdentifier = @"PayBillSegue";

@interface PSHomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myExpensesTableView;
@property (weak, nonatomic) IBOutlet UILabel *myAccountInfoLabel;
@property (weak, nonatomic) IBOutlet UIView *myAccountContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *payBillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *payMerchantImageView;
@property (weak, nonatomic) IBOutlet UIButton *payBillButton;
@property (weak, nonatomic) IBOutlet UIButton *payMerchantButton;

@end

@implementation PSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationItem setHidesBackButton:YES];
    [self setIconButton];
}

- (void)setIconButton {
    if (OS_VERSION_BEFORE(7.0f)) {
        UIButton *btn   = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame       = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
        btn.contentMode = UIViewContentModeCenter;
        [btn setImage:[UIImage imageNamed:@"launcher"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = backButton;
    } else {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"launcher"] style:UIBarButtonItemStylePlain target:self action:@selector(onBackButtonClicked:)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
}

- (void)onBackButtonClicked:(id)sender {

}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = 66.0f;
    return rowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.myExpensesTableView.backgroundColor = [UIColor whiteColor];
    UILabel *myExpensesHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.myExpensesTableView.frame.size.width - 30, 30)];
    myExpensesHeaderLabel.text = NSLocalizedString(@"My Expenses", nil);
    myExpensesHeaderLabel.textColor = [UIColor appPrimaryBlueColorButton];
    myExpensesHeaderLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:16.0f];
    [view addSubview:myExpensesHeaderLabel];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyExpensesTableViewCell *cell = (MyExpensesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kMyExpensesCellIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    //For iOS 8, we need the following code to set the cell separator line stretching to both left and right edge of the view.
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)payBillButtonClicked:(id)sender {
    [self performSegueWithIdentifier:kPayBillSegueIdentifier sender:self];
}

- (IBAction)payMerchantButtonClicked:(id)sender {
    [self performSegueWithIdentifier:kPayMerchantSegueIdentifier sender:self];
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
