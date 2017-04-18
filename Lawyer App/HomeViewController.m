//
//  HomeViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 24/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "AddCaseViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "FSCalendar.h"
#import "CaseListViewController.h"
#import "CaseStatusSearchViewController.h"
@interface HomeViewController ()
{
    //NSMutableDictionary * infoToPass;
    NSMutableDictionary *myDict;
    NSMutableDictionary *caseInfo;
    NSArray *dataArray;
    NSString *stringFromDate;
   // int i;
    NSMutableArray *caseIdArray;
    
}
@property (weak, nonatomic) IBOutlet UIView *addButtonView;
@property (strong, nonatomic) IBOutlet FSCalendar *calendarView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.navigationController.navigationBar.hidden = YES;
    
     //_addButtonView.layer.cornerRadius = 45;
        _addButtonView.layer.cornerRadius = self.addButtonView.frame.size.width/2;
        _addButtonView.clipsToBounds = YES;
    
          [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:)
         forControlEvents:UIControlEventTouchUpInside];
          [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
         //NSLog(@"my add case info - %@",_caseInfoToRecive);
    
        // caseIdArray = [[NSArray alloc]init];
    
//      myDict = [[NSMutableDictionary alloc]init];
    
    
//calendar properties
    
    
    //HIDE BOTTOM SWIPE UP VIEW
    _calendarView.showsScopeHandle = false;
    
    //SET DELEGATE AND DATASOURCE
    _calendarView.delegate = self;
    _calendarView.dataSource = self;
    
    //HIDE/ SHOW NEXTMONTH DATES
     _calendarView.placeholderType = FSCalendarPlaceholderTypeNone;
    
    //DISBALED SWIPE GESTURE
    _calendarView.swipeToChooseGesture.enabled = false;
    //SET COLOR ON CALENDAR
    _calendarView.calendarHeaderView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.1];
    _calendarView.calendarWeekdayView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.1];
    
    
    
    //HIDE MONTH LABEL VIEW
    self.calendarView.calendarHeaderView.hidden = false;
    //self.calendarView.headerHeight = 0.0;
     _calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
    self.calendarView.appearance.headerTitleColor = [UIColor whiteColor];
    
    
    
    //SET APPEARANCE 0F CALENDAR
    self.calendarView.appearance.weekdayFont = [UIFont fontWithName:@"Arial" size:15];
    self.calendarView.appearance.weekdayTextColor = [UIColor whiteColor];
    self.calendarView.appearance.todayColor = [UIColor redColor];
    self.calendarView.appearance.titleTodayColor = [UIColor colorWithRed:0.0/255.0 green:176.0/255.0 blue:159.0/255.0 alpha:1.0];
    
    self.calendarView.appearance.titleFont = [UIFont fontWithName:@"Calibri" size:15];
    self.calendarView.appearance.caseOptions = 2;
    self.calendarView.appearance.separators = 0;

    
}

-(IBAction)unwindToHomeScreen:(UIStoryboardSegue*)segue{
    
}
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
    return [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
   
    myDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash",[self getStringFromDate:date],@"case_detail_hearing_date", nil];
    
    NSLog(@"my Dict - %@",myDict);
    NSLog(@"%@",[self getStringFromDate:date]);
    [RequestManager getFromServer:@"get_user_cases" parameters:myDict completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
            [self showBasicAlert:@"No Network Available!!!" Message:@"User Registered!! Please Login now."];
            return ;
        }
        else{
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"0"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                return;
            }
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]){
            // [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"3"]){
                NSLog(@"case list - %@",responseDict);
                dataArray = [responseDict valueForKey:@"data"];
                
                stringFromDate =[NSString stringWithFormat:@"%@", [self getStringFromDate:date]];
                NSLog(@"calender date - %@",stringFromDate);
               
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                CaseListViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addedCaseList"];
                vc.userCaseInfo =dataArray;
                vc.stringToPass = stringFromDate;
                [self.navigationController pushViewController:vc animated:YES];
                
                }
                else  if([[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_groups_id"] isEqualToString:@"4"]){
                    
                    dataArray = [responseDict valueForKey:@"data"];
                    
                    
                    NSLog(@"case id - %@", [[NSUserDefaults standardUserDefaults]stringForKey:@"logged_case_id"]);
                    stringFromDate =[NSString stringWithFormat:@"%@", [self getStringFromDate:date]];
                    NSLog(@"calender date - %@",stringFromDate);
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    CaseStatusSearchViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"case status screen"];
                    vc.userInfo =dataArray;
                    vc.stringToAdd = stringFromDate;
                    [self.navigationController pushViewController:vc animated:YES];
                    

                }
            }
        }
    }]; // case list api ends
}
-(BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
        return true;
}
//convert date to string
-(NSString*)getStringFromDate:(NSDate*)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"dd"];
    NSString *dateString = [df stringFromDate:date];
    [df setDateFormat:@"MM"];
    NSString  *myMonthString = [df stringFromDate:date];
    [df setDateFormat:@"YYYY"];
    NSString  *myYearString = [df stringFromDate:date];
    return [NSString stringWithFormat:@"%@-%@-%@",myYearString,myMonthString,dateString];
    
}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)addCaseButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addCaseScreen"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
