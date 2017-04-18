//
//  CaseListViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 30/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "CaseListViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "SWRevealViewController.h"
#import "CaseListTableViewCell.h"
#import "CaseDetailViewController.h"
#import "AddCaseViewController.h"

@interface CaseListViewController ()<UITableViewDelegate,UITableViewDataSource>

  {
    NSMutableDictionary *caseInformationDict;
      NSString* stringToShow;
  }
@end

@implementation CaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
           _addButtonView.layer.cornerRadius =self.addButtonView.frame.size.width/2;
           _addButtonView.clipsToBounds = YES;
    
           NSLog(@"user case info  - %@",_userCaseInfo);
           caseInformationDict = [[NSMutableDictionary alloc]init];
    
   // date format
     NSDateFormatter *format = [[NSDateFormatter alloc] init];
     [format setDateFormat:@"YYYY-MM-dd"];
     NSDate *date = [format dateFromString:_stringToPass];
     [format setDateFormat:@"dd-MMM-YYYY"];
     stringToShow = [format stringFromDate:date];
    
    // table view  footer
      _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _userCaseInfo.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    CaseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.caseHearingDateLable.text =stringToShow;
    cell.caseTitleLable.text =[[_userCaseInfo objectAtIndex:indexPath.row] objectForKey:@"case_title"];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCaseButtonAction:(id)sender {
   
    // [self performSegueWithIdentifier:@"add case screen" sender:self];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addCaseScreen"];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [caseInformationDict  addEntriesFromDictionary:[_userCaseInfo objectAtIndex:indexPath.row]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CaseDetailViewController *viewController = (CaseDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"caseDetailScreen"];
    viewController.userCaseInfoDict =caseInformationDict;
    [self presentViewController:viewController animated:YES completion:nil];
   
}
- (IBAction)backButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
