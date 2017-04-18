//
//  CaseStatusSearchViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 13/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import "CaseStatusSearchViewController.h"
#import "RequestManager.h"
#import "CaseDetailViewController.h"
@interface CaseStatusSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *dictWithCaseSearch;
    NSMutableArray *dataArray;
    NSMutableDictionary *dictForCaseDetail;
   }
@end

@implementation CaseStatusSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_caseStatusSearchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     dictWithCaseSearch = [[NSMutableDictionary alloc] init];
     dictForCaseDetail = [[NSMutableDictionary alloc]init];
    
     _searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    dataArray = [[NSMutableArray alloc]init];
}
- (IBAction)caseTypeButtonAction:(id)sender {
    [dictWithCaseSearch setObject:@"1" forKey:@"case_search_in"];
}

- (IBAction)caseTitleButtonAction:(id)sender {
    [dictWithCaseSearch setObject:@"2" forKey:@"case_search_in"];

}

- (IBAction)judgeNameButtonAction:(id)sender {
    [dictWithCaseSearch setObject:@"3" forKey:@"case_search_in"];

}
- (IBAction)allButtonAction:(id)sender {
    [dictWithCaseSearch setObject:@"1" forKey:@"case_search_period"];
    
}
- (IBAction)weaklyButtonAction:(id)sender {
    [dictWithCaseSearch setObject:@"2" forKey:@"case_search_period"];

}


- (IBAction)caseStatusSearchButtonAction:(id)sender {
     [dictWithCaseSearch setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] forKey:@"user_id"];
     [dictWithCaseSearch setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"] forKey:@"user_security_hash"];
     [dictWithCaseSearch setObject:_caseStatusSearchTextField.text forKey:@"case_search_keyword"];

    
    [RequestManager getFromServer:@"search" parameters:dictWithCaseSearch completionHandler:^(NSDictionary *responseDict) {
        
        
        if ([[responseDict objectForKey:@"error"] isEqualToString:@"1"]) {
            [self showBasicAlert:@"No Network Availbale!!!" Message:@"Please connect to a working internet."];
            return;
        }
        else{
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"0"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:nil];
                return;
            }
            
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"1"]){
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:nil];

                  NSLog(@"  search -%@",responseDict);
                dataArray = [responseDict valueForKey:@"data"];
            
                
            }
        }
    }]; // search api end
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return dataArray.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
       
    }
//    UILabel *nextDateLabel = (UILabel *)[self.view viewWithTag:503];
//    UILabel *titleLabel = (UILabel *)[self.view viewWithTag:504];
    
//     nextDateLabel.text = _stringToAdd;
//    titleLabel = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"case_title"];
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // [dictForCaseDetail  addEntriesFromDictionary:[dataArray objectAtIndex:indexPath.row]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CaseDetailViewController *viewController = (CaseDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"caseDetailScreen"];
   // viewController.userCaseInfoDict =dictForCaseDetail;
    [self presentViewController:viewController animated:YES completion:nil];
   
    
}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)backButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
