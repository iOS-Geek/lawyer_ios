//
//  LoginViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "LoginViewController.h"
#define IS_STANDARD_IPHONE_6_PLUS ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ACCEPTABLE_CHARECTERS @"0123456789"
#import "RequestManager.h"

@interface LoginViewController ()

{
    NSMutableDictionary *dictWithUserMobileNumberAndPassword;
    NSMutableDictionary *userInfoFromResponse;
}

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [_mobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_corporateIdTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_businessUserMobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_businessUserPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
       // text field delegate
     _mobileNumberTextField.delegate = self;
     _passwordTextField.delegate = self;
    _corporateIdTextField.delegate = self;
    _businessUserMobileNumberTextField.delegate = self;
    _businessUserPasswordTextField.delegate = self;
    
    //store mobile number and password
     dictWithUserMobileNumberAndPassword = [[NSMutableDictionary alloc]init];
   
    //store response from server
     userInfoFromResponse = [[NSMutableDictionary alloc]init];

    //touches anywhere - keyboard hide
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
     [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)dismissKeyboard {

    [self.view endEditing:true];
}
# pragma mark - keyboard movements
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
    aRect.size.height  -= kbRect.size.height;
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
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_passwordTextField resignFirstResponder];
    }
    else if (textField.tag == 3) {
        [_businessUserMobileNumberTextField becomeFirstResponder];
    }
    else if (textField.tag == 4) {
        [_businessUserPasswordTextField becomeFirstResponder];
    }
    else if (textField.tag == 5) {
        [_businessUserPasswordTextField resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 1){
        if (_mobileNumberTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
        if(textField.tag == 4){
        if (_businessUserMobileNumberTextField.text.length >= 10 && range.length == 0)
            return NO;
    }

        if(textField.tag == 1){
             NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
             NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
             return [string isEqualToString:filtered];
    }
       if(textField.tag == 4){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }

            if(textField.tag == 2){
           [_passwordTextField setSecureTextEntry:YES];
    }
         if(textField.tag == 5){
        [_businessUserPasswordTextField setSecureTextEntry:YES];
    }
    
    
   return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma Login Button Action
- (IBAction)loginButtonAction:(id)sender {
    
    [dictWithUserMobileNumberAndPassword setObject:_mobileNumberTextField.text forKey:@"user_login"];
    [dictWithUserMobileNumberAndPassword setObject:_passwordTextField.text forKey:@"user_login_password"];
    
    //check user on server to login
    [RequestManager getFromServer:@"login" parameters:dictWithUserMobileNumberAndPassword completionHandler:^(NSDictionary *responseDict) {
        
        
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
                
                  userInfoFromResponse = [responseDict objectForKey:@"data"];
                  NSLog(@"info -%@",userInfoFromResponse);
                
                 [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
                
                }
           }
    }]; // login api end
}
    //A basic alert showing method
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
 #pragma segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginSuccessful"]) {
        HomeViewController *vc = (HomeViewController *)segue.destinationViewController;
        vc.userInfo = userInfoFromResponse;
    }
}
-(IBAction)unwindToLoginScreen:(UIStoryboardSegue*)segue{
    
}
@end
