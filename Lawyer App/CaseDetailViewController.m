//
//  CaseDetailViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "CaseDetailViewController.h"
#import "SWRevealViewController.h"
#import "AddCommentViewController.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@interface CaseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSMutableDictionary * dictSendCaseDetailsEmail;
   
}

@end

@implementation CaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
      _messageButtonView.layer.cornerRadius = self.messageButtonView.frame.size.width/2;
      _messageButtonView.clipsToBounds = YES;
    
    [self.messageButtonView.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.messageButtonView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.messageButtonView.layer setShadowOpacity:1.0];
    
    //dictSendCaseDetailsEmail = [[NSMutableDictionary alloc]init];
    
      NSLog(@" case Detail info - %@", _userCaseInfoDict);
      [[NSUserDefaults standardUserDefaults]setObject:[_userCaseInfoDict valueForKey:@"case_id"] forKey:@"logged_case_id"];
      NSLog(@"case id -%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"logged_case_id"] );
    
    if ([[_userCaseInfoDict objectForKey:@"case_type"] isEqualToString:@""]) {
        
        _caseTypeViewHeightConst.constant = 0;
    }
    if ([[_userCaseInfoDict objectForKey:@"case_number"] isEqualToString:@""]) {
        
        _caseNumberViewHeightConst.constant = 0;
    }
     if ([[_userCaseInfoDict objectForKey:@"case_title"] isEqualToString:@""]) {
        
        _caseTitleViewHeightConst.constant = 0;
    }
     if ([[_userCaseInfoDict objectForKey:@"case_court_name"] isEqualToString:@""]) {
        
        _judgenameViewHeightConst.constant = 0;
    }

      if ([[_userCaseInfoDict objectForKey:@"case_position_status"] isEqualToString:@""]) {
        
        _caseStatusViewHeightConst.constant = 0;
    }

      if ([[_userCaseInfoDict objectForKey:@"case_start_date"] isEqualToString:@""]) {
        
        _satartDateViewHeightConst.constant = 0;
    }

      if ([[_userCaseInfoDict objectForKey:@"case_retained_name"] isEqualToString:@""]) {
        
        _retainedViewHeightConst.constant = 0;
    }
      if ([[_userCaseInfoDict objectForKey:@"case_retained_contact"] isEqualToString:@""]) {
        
        _contectViewHeightConst.constant = 0;
    }

      if ([[_userCaseInfoDict objectForKey:@"case_opposite_counselor_name"] isEqualToString:@""]) {
        
        _oppositeCounselHeightConst.constant = 0;
    }
      if ([[_userCaseInfoDict objectForKey:@"case_opposite_counselor_contact"] isEqualToString:@""]) {
        
        _oppositeCounselContectViewHeightConst.constant = 0;
    }
       //  scroll view delegate
       self.scroller.delegate=self;
       [self.scroller setContentSize:CGSizeMake(self.scroller.frame.size.width, self.caseDetailTable.frame.size.height+self.caseDetailTable.frame.origin.y+180)];
   
    
    _caseNumberLabel.text = [_userCaseInfoDict objectForKey:@"case_number"];
    _caseTitleLabel .text = [_userCaseInfoDict objectForKey:@"case_title"];
    _judgeNameLabel.text = [_userCaseInfoDict objectForKey:@"case_court_name"];
    _caseStatusLabel.text = [_userCaseInfoDict objectForKey:@"case_position_status"];
    _startDateLabel.text = [_userCaseInfoDict objectForKey:@"case_start_date"];
    _retainedNameLabel.text = [_userCaseInfoDict objectForKey:@"case_retained_name"];
    _retainedContectLabel.text =[_userCaseInfoDict objectForKey:@"case_retained_contact"];
    _oppositeCounselNameLabel.text =[_userCaseInfoDict objectForKey:@"case_opposite_counselor_name"];
    _oppositeCounselContectLabel.text =[_userCaseInfoDict objectForKey:@"case_opposite_counselor_contact"];
    _caseTypeLabel.text = [_userCaseInfoDict objectForKey:@"case_type"];
    

    
    // footer view
    _caseDetailTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
   
//    CGRect contentRect = CGRectZero;
//    for (UIView *view in self.scroller.subviews) {
//        contentRect = CGRectUnion(contentRect, view.frame);
//    }
//    self.scroller.contentSize = contentRect.size;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_userCaseInfoDict objectForKey:@"case_details_array"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    UILabel *nextDateLabel = (UILabel *)[self.view viewWithTag:501];
    UILabel *commentLabel = (UILabel *)[self.view viewWithTag:502];
    
    nextDateLabel.text = [[[_userCaseInfoDict objectForKey:@"case_details_array"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_hearing_date"];
    commentLabel.text = [[[_userCaseInfoDict objectForKey:@"case_details_array"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_comment"];
    
    return cell;
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addCommentButtonActon:(id)sender {
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCommentViewController *viewController = (AddCommentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"add comment"];
  
    [self presentViewController:viewController animated:YES completion:nil];
   
}
- (IBAction)emailVarificationButtonAction:(id)sender {
    dictSendCaseDetailsEmail = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_case_id"],@"case_id", nil];
    
    [RequestManager getFromServer:@"send_case_details_email" parameters:dictSendCaseDetailsEmail completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
            [self showBasicAlert:@"No Network Availbale!!!" Message:@"Please connect to a working internet."];
            return ;
        }
        else{
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"0"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                return;
            }
            
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"1"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSLog(@" Send Case Details Email status %@",responseDict);
                
            }
        }
    }]; //send case details email api ends
}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
