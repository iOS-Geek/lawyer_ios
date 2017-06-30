//
//  CaseDetailViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "CaseDetailViewController.h"
@interface CaseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSMutableDictionary * dictSendCaseDetailsEmail;
    NSMutableDictionary * dictForViewCases;
    NSDictionary *dictToShowCaseDetail;
    NSArray *arrayForHearingDate;
    NSArray *arryForComment;
    NSString *dateString;
    NSString *stringToShowInDetailTable;
    NSString *caseStausId;
    NSDictionary *casesDetailDictoffline;
    NSMutableDictionary *caseDetailDictoffline1;
    NSMutableDictionary *caseDetailsFinal;
    NSMutableDictionary *dicty;
    BOOL showoffline;
    BOOL saveRootBoolValue;
    BOOL access;
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *problem;

@end

@implementation CaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"case id %@",_caseidget);
    showoffline = NO;
    saveRootBoolValue = [[NSUserDefaults standardUserDefaults]boolForKey:@"titleshow"];
    _caseDetailTable.delegate = self;
    _caseDetailTable.dataSource = self;
    casesDetailDictoffline = [[NSDictionary alloc]init];
    caseDetailDictoffline1=[[NSMutableDictionary alloc]init];
    caseDetailsFinal = [[NSMutableDictionary alloc]init];
    dicty = [[NSMutableDictionary alloc]init];
    dicty = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]dictionaryForKey:@"saveData1"]];
    
    // Alert View
    _mainScrollView.hidden=YES;
    dictToShowCaseDetail = [[NSDictionary alloc]init];
    
    // message Button Corner radius
    _messageButtonView.layer.cornerRadius = self.messageButtonView.frame.size.width/2;
    _messageButtonView.clipsToBounds = YES;
    
    
    [self.messageButtonView.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.messageButtonView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.messageButtonView.layer setShadowOpacity:1.0];
    
    [[NSUserDefaults standardUserDefaults]setObject:[_userCaseInfoDict valueForKey:@"case_id"] forKey:@"logged_case_id"];
    
    _assignToViewHeightConst.constant = 0;
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"5"]){
        
        _assignToViewHeightConst.constant = 49;
        
    }
    
    
    // View case Api
    dictForViewCases = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_case_id"],@"case_id", nil];
    
    // Activity Indicator To Show Loading
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center=self.view.center;
    activityView.color = [UIColor blackColor];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    [RequestManager getFromServer:@"view_case" parameters:dictForViewCases completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
            NSLog(@"case id %@",_caseidget);
            _mainScrollView.hidden=NO;
            //            [self showBasicAlert:@"No Network Availbale!!!" Message:@"Please connect to a working internet."];
            showoffline = YES;
            saveRootBoolValue = YES;
            casesDetailDictoffline = [[NSUserDefaults standardUserDefaults]dictionaryForKey:@"initialData"];
            [activityView stopAnimating];
            
        }
        else{
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"0"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                [activityView stopAnimating];
                return;
            }
            
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"1"]) {
                
                _mainScrollView.hidden=NO;
                showoffline = NO;
                saveRootBoolValue = NO;
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                
                
                casesDetailDictoffline = responseDict;
                if(![[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"]  isEqual: @"3"]){
                    [[NSUserDefaults standardUserDefaults]setObject:casesDetailDictoffline forKey:@"initialData"];
                }
                
                
            }
        }
        
        if (saveRootBoolValue == YES) {
            if ([dicty objectForKey:_caseidget]) {
                NSDictionary *dictionary = [[NSDictionary alloc]init];
                dictionary = [[dicty objectForKey:_caseidget] objectForKey:@"data"];
                NSLog(@"ss %@",dictionary);
                dictToShowCaseDetail  = dictionary;
            }
            else{
                [self dismissViewControllerAnimated:NO completion:nil];
                [self showBasicAlert:@"Error!!" Message:@"Details were not fetched online"];
            }
        }
        else{
            dictToShowCaseDetail  = [casesDetailDictoffline valueForKey:@"data"];
        }
        
        
        if ([casesDetailDictoffline valueForKey:@"data"]) {
            NSLog(@"%@",casesDetailDictoffline);
            [caseDetailDictoffline1 addEntriesFromDictionary:casesDetailDictoffline];
            
            if (_caseidget != nil) {
                [caseDetailsFinal setObject:caseDetailDictoffline1 forKey:_caseidget];
            }
            
        }
        
        if (showoffline == NO) {
            if ([dicty objectForKey:_caseidget]) {
                [dicty removeObjectForKey:_caseidget];
                [dicty addEntriesFromDictionary:caseDetailsFinal];
            }
            else{
                [dicty addEntriesFromDictionary:caseDetailsFinal];
            }
            if(![[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"]  isEqual: @"3"]){
                [[NSUserDefaults standardUserDefaults]setObject:dicty forKey:@"saveData1"];
            }
            
        }
        NSLog(@"final offline dict %@",dicty);
        NSMutableDictionary *mutableDict = [dictToShowCaseDetail mutableCopy];
        for (NSString *key in [dictToShowCaseDetail allKeys])
        {
            if ([dictToShowCaseDetail[key] isEqual:[NSNull null]])
            {
                mutableDict[key] = @"";//or [NSNull null] or whatever value you want to change it to
            }
        }
        
        dictToShowCaseDetail = [mutableDict copy];
        NSLog(@" case detail ---  %@",dictToShowCaseDetail);
        
        
        
        
        if ([[dictToShowCaseDetail objectForKey:@"case_type"] isEqualToString:@""]) {
            
            _caseTypeViewHeightConst.constant = 0;
            //_caseStatusLabel.text = @""
        }
        if ([[dictToShowCaseDetail objectForKey:@"case_number"] isEqualToString:@""]) {
            
            _caseNumberViewHeightConst.constant = 0;
        }
        if ([[dictToShowCaseDetail objectForKey:@"case_title"] isEqualToString:@""]) {
            
            _caseTitleViewHeightConst.constant = 0;
        }
        if ([[dictToShowCaseDetail objectForKey:@"case_court_name"] isEqualToString:@""]) {
            
            _judgenameViewHeightConst.constant = 0;
        }
        
        if ([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@""]) {
            
            _caseStatusViewHeightConst.constant = 0;
        }
        
        if ([[dictToShowCaseDetail objectForKey:@"case_start_date"] isEqualToString:@""]) {
            
            _satartDateViewHeightConst.constant = 0;
        }
        
        if ([[dictToShowCaseDetail objectForKey:@"case_retained_name"] isEqualToString:@""]) {
            
            _retainedViewHeightConst.constant = 0;
        }
        if ([[dictToShowCaseDetail objectForKey:@"case_retained_contact"] isEqualToString:@""]) {
            
            _contectViewHeightConst.constant = 0;
        }
        
        if ([[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"] isEqualToString:@""]) {
            
            _oppositeCounselHeightConst.constant = 0;
        }
        if ([[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"] isEqualToString:@""]) {
            
            _oppositeCounselContectViewHeightConst.constant = 0;
        }
        
        // Details To Show Free User
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"3"]){
            
            _assignToViewHeightConst.constant = 0;
            _caseStatusLabel.text = [dictToShowCaseDetail objectForKey:@"case_position_status"];
            _caseNumberLabel.text = [dictToShowCaseDetail objectForKey:@"case_number"];
            _caseTitleLabel .text = [dictToShowCaseDetail objectForKey:@"case_title"];
            _judgeNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_court_name"];
            _startDateLabel.text = [dictToShowCaseDetail objectForKey:@"case_start_date"];
            _retainedNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_retained_name"];
            _retainedContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_retained_contact"];
            _oppositeCounselNameLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"];
            _oppositeCounselContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"];
            _caseTypeLabel.text = [dictToShowCaseDetail objectForKey:@"case_type"];
            // Colors To Show Free User For Case Status
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Written Statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"written statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Cross to Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"cross to plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Cross to Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"cross to defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:128 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:102 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"Reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_position_status"] isEqualToString:@"reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            
        }
        // Details To Show  indivisual Paid User
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"4"]){
            _assignToViewHeightConst.constant = 0;
            caseStausId =[[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_statuses_id"];
            NSLog(@"DDDDDDDD %@", caseStausId);
            if( [caseStausId isEqualToString:@"0"]){
                
                _caseStatusLabel.text = [[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_detail_status_other"];
                _caseNumberLabel.text = [dictToShowCaseDetail objectForKey:@"case_number"];
                _caseTitleLabel .text = [dictToShowCaseDetail objectForKey:@"case_title"];
                _judgeNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_court_name"];
                _startDateLabel.text = [dictToShowCaseDetail objectForKey:@"case_start_date"];
                _retainedNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_retained_name"];
                _retainedContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_retained_contact"];
                _oppositeCounselNameLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"];
                _oppositeCounselContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"];
                _caseTypeLabel.text = [dictToShowCaseDetail objectForKey:@"case_type"];
            }
            else if(![caseStausId isEqualToString:@"0"])
                _caseStatusLabel.text = [[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_status_name"];
            _caseNumberLabel.text = [dictToShowCaseDetail objectForKey:@"case_number"];
            _caseTitleLabel .text = [dictToShowCaseDetail objectForKey:@"case_title"];
            _judgeNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_court_name"];
            _startDateLabel.text = [dictToShowCaseDetail objectForKey:@"case_start_date"];
            _retainedNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_retained_name"];
            _retainedContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_retained_contact"];
            _oppositeCounselNameLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"];
            _oppositeCounselContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"];
            _caseTypeLabel.text = [dictToShowCaseDetail objectForKey:@"case_type"];
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Written Statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"written statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross to Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross to plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross to Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross to defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:128 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:102 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            
            
        }
        // Details To Show  Bussiness  User
        
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"5"]){
            
            _assignToViewHeightConst.constant = 49;
            caseStausId =[[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_statuses_id"];
            NSLog(@"DDDDDDDD %@", caseStausId);
            if( [caseStausId isEqualToString:@"0"]){
                
                _caseStatusLabel.text = [[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_detail_status_other"];
                _caseNumberLabel.text = [dictToShowCaseDetail objectForKey:@"case_number"];
                _caseTitleLabel .text = [dictToShowCaseDetail objectForKey:@"case_title"];
                _judgeNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_court_name"];
                _startDateLabel.text = [dictToShowCaseDetail objectForKey:@"case_start_date"];
                _retainedNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_retained_name"];
                _retainedContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_retained_contact"];
                _oppositeCounselNameLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"];
                _oppositeCounselContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"];
                _caseTypeLabel.text = [dictToShowCaseDetail objectForKey:@"case_type"];
                _AssignToLabel.text =[NSString stringWithFormat:@"%@ %@%@%@%@",  [dictToShowCaseDetail objectForKey:@"user_name"],[dictToShowCaseDetail objectForKey:@"user_last_name"],@"(",[dictToShowCaseDetail objectForKey:@"user_contact"],@")"];
                
                
            }
            else if(![caseStausId isEqualToString:@"0"])
                _caseStatusLabel.text = [[[dictToShowCaseDetail objectForKey:@"case_details"] firstObject] objectForKey:@"case_status_name"];
            _caseNumberLabel.text = [dictToShowCaseDetail objectForKey:@"case_number"];
            _caseTitleLabel .text = [dictToShowCaseDetail objectForKey:@"case_title"];
            _judgeNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_court_name"];
            _startDateLabel.text = [dictToShowCaseDetail objectForKey:@"case_start_date"];
            _retainedNameLabel.text = [dictToShowCaseDetail objectForKey:@"case_retained_name"];
            _retainedContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_retained_contact"];
            _oppositeCounselNameLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_name"];
            _oppositeCounselContectLabel.text =[dictToShowCaseDetail objectForKey:@"case_opposite_counselor_contact"];
            _caseTypeLabel.text = [dictToShowCaseDetail objectForKey:@"case_type"];
            _AssignToLabel.text =[NSString stringWithFormat:@"%@ %@%@%@%@",  [dictToShowCaseDetail objectForKey:@"user_name"],[dictToShowCaseDetail objectForKey:@"user_last_name"],@"(",[dictToShowCaseDetail objectForKey:@"user_contact"],@")"];
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"notice"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Written Statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"written statement"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross to Plaintiff Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross to plaintiff evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"application"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"order"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor redColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross to Defendent Evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross to defendent evidence"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1] ;
            }
            
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"arguments"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:139 green:0 blue:0 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:128 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"cross"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:102 blue:255 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"consideration"]){
                _caseStatusLabel.textColor = [UIColor colorWithRed:0 green:255 blue:127 alpha:1] ;
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"Reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            if([[dictToShowCaseDetail objectForKey:@"case_status_name"] isEqualToString:@"reply"]){
                _caseStatusLabel.textColor = [UIColor greenColor];
            }
            
            
            
        }
        
        // footer view
        _caseDetailTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        // Update last Case Hearing Date
        NSString*latesttDate = [dictToShowCaseDetail  objectForKey:@"case_latest_hearing_date"];
        NSString*today  = [dictToShowCaseDetail  objectForKey:@"current_date"];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"YYYY-MM-dd"];
        NSDate *newDate = [format dateFromString:latesttDate];
        NSDate *newDate1 = [format dateFromString:today];
        
        NSComparisonResult result;
        //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
        
        result = [newDate1 compare:newDate]; // comparing two dates
        
        if(result==NSOrderedAscending  ||[[dictToShowCaseDetail objectForKey:@"case_is_decided"] isEqualToString:@"1"])
        {
            self.addMoreCommentsBtn.hidden=YES;
        }
        else if(result==NSOrderedDescending ||[[dictToShowCaseDetail objectForKey:@"case_is_decided"] isEqualToString:@"0"])
        {
            NSLog(@"newDate is less");
            self.addMoreCommentsBtn.hidden=NO;
        }
        else if(result==NSOrderedSame ||[[dictToShowCaseDetail objectForKey:@"case_is_decided"] isEqualToString:@"0"])
        {
            self.addMoreCommentsBtn.hidden=NO;
            
            NSLog(@"Both dates are same");
        }
        
        // Estimated table view  row height
        self.caseDetailTable.estimatedRowHeight = 64;
        self.caseDetailTable.rowHeight = UITableViewAutomaticDimension;
        
        
        [self.caseDetailTable reloadData];
        
        
        
        
        [activityView stopAnimating];
    }]; //  View Case  Api ends
}

# pragma Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[dictToShowCaseDetail objectForKey:@"case_details"] count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    UILabel *nextDateLabel = (UILabel *)[cell.contentView viewWithTag:501];
    UILabel *commentLabel = (UILabel *)[cell.contentView viewWithTag:502];
    
    dateString = [[[dictToShowCaseDetail objectForKey:@"case_details"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_hearing_date"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"dd-MMM-YYYY"];
    stringToShowInDetailTable = [format stringFromDate:date];
    nextDateLabel.text = stringToShowInDetailTable;
    commentLabel.text = [[[dictToShowCaseDetail objectForKey:@"case_details"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_comment"];
    NSLog(@" my Dict %@",[[[dictToShowCaseDetail objectForKey:@"case_details"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_hearing_date"]);
    NSLog(@" my Dict %@",[[[dictToShowCaseDetail objectForKey:@"case_details"] objectAtIndex:indexPath.row] objectForKey:@"case_detail_comment"]);
    
    _problem.constant = 49;
    [self.view layoutIfNeeded];
    [_caseDetailTable layoutIfNeeded];
    
    return cell;
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Table View Height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//Add Comment Button Action
- (IBAction)addCommentButtonActon:(id)sender {
    [self checkinternet];
    
    if (access == NO) {
        //        [self dismissViewControllerAnimated:NO completion:nil];
        [self showBasicAlert:@"Error!!" Message:@"Please connect to a working internet"];
        
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCommentViewController *viewController = (AddCommentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"add comment"];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}
// Email Verification link Api
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
// Show BasicAlert
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)checkinternet{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/"];
    
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    //Manual timeout of 20 seconds
    [NSThread sleepForTimeInterval: 1];
    if (data){
        NSLog(@"Device is connected to the Internet");
        access = YES;}
    
    else{
        NSLog(@"Device is not connected to the Internet");
        access = NO;}
    
    
}

@end
