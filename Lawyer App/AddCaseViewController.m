//
//  AddCaseViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AddCaseViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "HomeViewController.h"
#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface AddCaseViewController ()<UITextFieldDelegate>
{
    NSMutableDictionary *caseInfoToPass;
    NSMutableDictionary *myDict;
    NSMutableString *str1;
    NSMutableString *str2;
}
@end

@implementation AddCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
     _addCommentTextField.delegate =self;
     _oppositeCounselContectTextField.delegate =self;
     _oppositeCounselNameTextField.delegate =self;
     _caseReatainedContectTextField.delegate =self;
     _caseRetainedNameTextField.delegate =self;
     _nextDateTextField.delegate =self;
     _caseStatusTextField.delegate =self;
     _caseNumberTextField.delegate =self;
     _judgeNameTextField.delegate =self;
     _caseTypeTextField.delegate =self;
     _previousDateTextField.delegate =self;
     _startDateTextField.delegate =self;
     _caseTitleTextField.delegate =self;
     _caseAmountTextField.delegate = self;
    
     caseInfoToPass =[[NSMutableDictionary alloc]init];
     myDict =[[NSMutableDictionary alloc]init];
    
     str1 =[[NSMutableString alloc]init];
     str2 =[[NSMutableString alloc]init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
   
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
//    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(168.5, 20, 138, 140)];
//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    [self.startDateTextField setInputView:datePicker];
    
}
//-(void)updateTextField:(id)sender
//{
//    UIDatePicker *picker = (UIDatePicker*)self.startDateTextField.inputView;
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"dd-MM-yyyy"];
//    self.startDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:picker.date]];
//    
//}
-(void)dismissKeyboard {
    
    [self.view endEditing:true];
}
- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    _activeField = sender;
}
- (void)textFieldDidEndEditing:(UITextField *)sender
{
    _activeField = nil;
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+10.0, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
        [_scrollView scrollRectToVisible:_activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}
# pragma Textfield Delegate METHODS
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [_previousDateTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_caseTitleTextField becomeFirstResponder];
    }
    else if (textField.tag == 3) {
        [_caseTypeTextField becomeFirstResponder];
    }
    else if (textField.tag == 4) {
        [_caseAmountTextField becomeFirstResponder];
    }
    else if (textField.tag == 5) {
        [_judgeNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 6) {
        [_caseNumberTextField becomeFirstResponder];
    }
    else if (textField.tag == 7) {
        [_caseStatusTextField becomeFirstResponder];
    }
    else if (textField.tag == 8) {
        [_nextDateTextField becomeFirstResponder];
    }
    else if (textField.tag == 9) {
        [_caseRetainedNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 10) {
        [_caseReatainedContectTextField becomeFirstResponder];
    }
    else if (textField.tag == 11) {
        [_oppositeCounselNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 12) {
        [_oppositeCounselContectTextField becomeFirstResponder];
    }
    else if (textField.tag == 13) {
        [_addCommentTextField becomeFirstResponder];
    }
    else if (textField.tag == 14) {
        [_addCommentTextField resignFirstResponder];
    }
   
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 11){
        if (_caseReatainedContectTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
    if(textField.tag == 11){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    if(textField.tag == 13){
        if (_oppositeCounselContectTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
    if(textField.tag == 13){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCaseButtonAction:(id)sender {
    str1 =[NSMutableString stringWithFormat:@"%@", [_infoToPass objectForKey:@"user_id"]];
    str2 =[NSMutableString stringWithFormat:@"%@", [_infoToPass objectForKey:@"user_security_hash"]];
    
    myDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:str1 ,@"user_id",str2,@"user_security_hash",_startDateTextField.text,@"case_start_date",_previousDateTextField.text,@"case_previous_date",_caseTitleTextField.text ,@"case_title",_caseTypeTextField.text,@"case_type",_judgeNameTextField.text,@"case_court_name",_caseNumberTextField.text,@"case_number",_caseStatusTextField.text,@"case_position_status",_nextDateTextField.text,@"case_next_date",_caseRetainedNameTextField.text,@"case_retained_name",_caseReatainedContectTextField.text,@"case_retained_contact",_oppositeCounselNameTextField.text,@"case_opposite_counselor_name",_oppositeCounselContectTextField.text,@"case_opposite_counselor_contact",_addCommentTextField.text,@"case_detail_comment", nil];
    
     
       [RequestManager getFromServer:@"add_case" parameters:myDict completionHandler:^(NSDictionary *responseDict) {
        
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
                NSLog(@" add case status %@", responseDict);
                
                [caseInfoToPass addEntriesFromDictionary:myDict];
               // [self performSegueWithIdentifier:@"confirm screen" sender:self];
            }
        }
    }]; //add case api ends
}
#pragma segue methods
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"confirm screen"]) {
//        //pass info to next screen
//        HomeViewController *vc = (HomeViewController *)segue.destinationViewController;
//        vc.caseInfoToRecive =caseInfoToPass;
//    }
//}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
