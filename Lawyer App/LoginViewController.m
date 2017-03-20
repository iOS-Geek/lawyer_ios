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

@interface LoginViewController ()<UITextFieldDelegate>

{
    NSMutableDictionary *dictWithUserMobileNumberAndPassword;
    NSMutableDictionary *userInfoFromResponse;
}

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _clickedDone.returnKeyType = UIReturnKeyDone;
    
    _mobileNumberTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    //store mobile number and password
    dictWithUserMobileNumberAndPassword = [[NSMutableDictionary alloc]init];
   
    //store response from server
    userInfoFromResponse = [[NSMutableDictionary alloc]init];

    //touches anywhere - keyboard hide
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard {

    [self.view endEditing:true];
}
#pragma mark - keyboard movements
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}


# pragma Textfield Delegate METHODS
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //mobile number field
     if (textField.tag == 1) {
         _loginButtonBottomConst.constant = 266;
        if (IS_STANDARD_IPHONE_6_PLUS) {
        _loginButtonBottomConst.constant = 290;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
        }];
    }
     //password field
    else{
        _loginButtonBottomConst.constant = 230;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _loginButtonBottomConst.constant = 244;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _loginButtonBottomConst.constant = 20;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 1){
        if (_mobileNumberTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
        if(textField.tag == 1){
             NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
             NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
             return [string isEqualToString:filtered];
    }
        if(textField.tag == 2){
          
          [_passwordTextField setSecureTextEntry:YES];
    }
              return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#  pragma Login Button Action
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
    }]; 
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"LoginSuccessful"]) {
        HomeViewController *vc = (HomeViewController *)segue.destinationViewController;
        vc.userInfo = userInfoFromResponse;
    }
}
-(IBAction)unwindToLoginScreen:(UIStoryboardSegue*)segue{
    
}
@end
