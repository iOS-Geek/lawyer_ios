//
//  AdvancedSearchViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 13/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import "AdvancedSearchViewController.h"
#import "RequestManager.h"
#import "CaseDetailViewController.h"
@interface AdvancedSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableDictionary * advancesCaseSearchDictionary;
     NSMutableDictionary * dictForCaseStatus;
    NSInteger selectedRow;
    NSArray *searchedArray;
    NSArray *dataArray;
    NSArray * arrToShowInTable;
}
@end

@implementation AdvancedSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_dropDownTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    advancesCaseSearchDictionary = [[NSMutableDictionary alloc]init];
    dictForCaseStatus = [[NSMutableDictionary alloc]init];
   
    searchedArray =[[NSArray alloc]init];
   
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIPickerView *myPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    myPicker.backgroundColor = [UIColor lightGrayColor];
    myPicker.dataSource = self;
    myPicker.delegate = self;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
    [toolBar setBarTintColor:[UIColor grayColor]];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barButtonDone =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(updatePickerData:)];
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, barButtonDone, nil];
    [toolBar setItems:itemsArray];
    barButtonDone.tintColor=[UIColor blackColor];
    
    self.dropDownTextField.inputView = myPicker;
    self.dropDownTextField.inputAccessoryView = toolBar;
    
    // get case status api
    
    [dictForCaseStatus setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_user_id" ] forKey:@"user_id"];
    [dictForCaseStatus setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_user_security_hash" ] forKey:@"user_security_hash"];

    [RequestManager getFromServer:@"get_case_statuses" parameters:dictForCaseStatus completionHandler:^(NSDictionary *responseDict) {
        
        
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
//                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:nil];
                
                NSLog(@" case status -%@",responseDict);
                dataArray =[responseDict valueForKey:@"data"];
                searchedArray = [dataArray valueForKey:@"case_status_id"];
                
            }
        }
    }]; // get case status api end

   _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
# pragma Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return searchedArray.count;
}
-(NSString *)pickerView:(UIPickerView *)tagPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [searchedArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    selectedRow = row;
}
-(void)updatePickerData:(id)sender
{
     _dropDownTextField.text= searchedArray[selectedRow];
        [[self view] endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)allButtonAction:(id)sender {
    [advancesCaseSearchDictionary setObject:@"1" forKey:@"case_search_period"];
}
- (IBAction)weaklyButtonAction:(id)sender {
    [advancesCaseSearchDictionary setObject:@"2" forKey:@"case_search_period"];
}

- (IBAction)searchButtonAction:(id)sender {
    [advancesCaseSearchDictionary setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] forKey:@"user_id"];
    [advancesCaseSearchDictionary setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"] forKey:@"user_security_hash"];
    [advancesCaseSearchDictionary setObject:_dropDownTextField.text forKey:@"case_status_id"];
   
    
    
    [RequestManager getFromServer:@"advanced_search" parameters:advancesCaseSearchDictionary completionHandler:^(NSDictionary *responseDict) {
        
        
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

                NSLog(@" advanced search -%@",responseDict);
             //   NSArray *dictArray =[responseDict valueForKey:@"data"];
//                [arrToShowInTable arrayByAddingObjectsFromArray:dictArray];
                
                
            }
        }
    }]; // advanced search api end
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return arrToShowInTable.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        
//    }
//        UILabel *nextDateLabel = (UILabel *)[self.view viewWithTag:505];
//        UILabel *titleLabel = (UILabel *)[self.view viewWithTag:506];
//    
//        nextDateLabel.text = [[arrToShowInTable objectAtIndex:indexPath.row] objectForKey:@"case_start_date"];
//        titleLabel = [[arrToShowInTable objectAtIndex:indexPath.row] objectForKey:@"case_title"];
    

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
@end
