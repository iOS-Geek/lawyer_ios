//
//  RegisterViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "RegisterViewController.h"
#import "RequestManager.h"
#define IS_STANDARD_IPHONE_6_PLUS ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface RegisterViewController ()
{
    NSMutableDictionary *userInfoFromResponse;
    NSMutableDictionary *dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_userNameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_mobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_emailTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_confirmPasswordtextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
   
    // text field delegates
    _userNameTextField.delegate = self;
    _mobileNumberTextField.delegate = self;
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    _confirmPasswordtextField.delegate = self;
    
    dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword= [[NSMutableDictionary alloc]init];
    
    //store response from server
     userInfoFromResponse = [[NSMutableDictionary alloc]init];
    _userInfo= [[NSMutableDictionary alloc]init];
    _userInfoToPass= [[NSMutableDictionary alloc]init];
   
    
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
     [self.view addGestureRecognizer:tap];
    
   

}
 -(void)dismissKeyboard {
    
    [self.view endEditing:true];
}
#pragma mark - keyboard movements
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //name field
    if (textField.tag == 1) {
        _imageTopConstraint.constant= -170;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //mobile number field
    else if (textField.tag == 2){
        _imageTopConstraint.constant = -165;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //email  field
    else if (textField.tag == 3){
        _imageTopConstraint.constant = -161;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //password field
    else if (textField.tag == 4){
        _imageTopConstraint.constant = -158;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //confirm password field
    else if (textField.tag == 5){
        _imageTopConstraint.constant = -155;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _imageTopConstraint.constant = 2;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
# pragma Textfield Delegate METHODS
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
      if (textField.tag == 1) {
        [_mobileNumberTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_emailTextField becomeFirstResponder];
    }
    else if (textField.tag == 3) {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField.tag == 4) {
        [_confirmPasswordtextField becomeFirstResponder];
    }
    else if (textField.tag == 5) {
        [_confirmPasswordtextField resignFirstResponder];
    }
        return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 2){ 
        if (_mobileNumberTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
    if(textField.tag == 2){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    if(textField.tag == 4){
        
        [_passwordTextField setSecureTextEntry:YES];
    }
    if(textField.tag == 5){
        
        [_confirmPasswordtextField setSecureTextEntry:YES];
    }

    return YES;
}
- (IBAction)registorButtonAction:(id)sender {
    [ dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_userNameTextField.text forKey:@"user_name"];
    [ dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_emailTextField.text forKey:@"user_email"];
    [ dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_mobileNumberTextField.text forKey:@"user_contact"];
    [ dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_passwordTextField.text forKey:@"user_login_password"];
    [ dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_confirmPasswordtextField.text forKey:@"confirm_login_password"];
    
    [_userInfo addEntriesFromDictionary: dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword];
    
    
    //register user on server - hit api
    [RequestManager getFromServer:@"signup" parameters:_userInfo completionHandler:^(NSDictionary *responseDict) {
        
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
//              [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSLog(@" signup status %@", responseDict);
                
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                
                _userInfoToPass =[NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDict valueForKey:@"user_id"],@"user_id",[dataDict  valueForKey:@"user_security_hash"],@"user_security_hash", nil];
                
                [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"otp_Verification_Done"];
                [self performSegueWithIdentifier:@"confirm screen" sender:self];
            }
        }
    }]; //signup api ends
}
#pragma segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"confirm screen"]) {
        //pass info to next screen
        ConfirmViewController *vc = (ConfirmViewController *)segue.destinationViewController;
        vc.userInfoToRecive =_userInfoToPass;
    }
}
 #pragma alert methods
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

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
