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
#import "MasterUserViewController.h"

@interface LoginViewController ()<UIScrollViewDelegate>

{
    NSMutableDictionary *dictWithUserMobileNumberAndPassword;
    NSMutableDictionary *userInfoFromResponse;
    NSMutableDictionary *dictWithCorporateIdAndMobileNumberAndPassword;
    BOOL scrollDirectionDetermined;
}

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
//    _scrollView.frame = CGRectMake(0,0,45,45);
    
     [_mobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_corporateIdTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_businessUserMobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [_businessUserPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     _scrollView.delegate = self;
    
       // text field delegate
     _mobileNumberTextField.delegate = self;
     _passwordTextField.delegate = self;
    _corporateIdTextField.delegate = self;
    _businessUserMobileNumberTextField.delegate = self;
    _businessUserPasswordTextField.delegate = self;
    
    //store mobile number and password
    dictWithUserMobileNumberAndPassword = [[NSMutableDictionary alloc]init];
    dictWithCorporateIdAndMobileNumberAndPassword = [[NSMutableDictionary alloc]init];
   
    //store response from server
     userInfoFromResponse = [[NSMutableDictionary alloc]init];

    //touches anywhere - keyboard hide
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
     [self.view addGestureRecognizer:tap];
    
}

# pragma scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
   // dragable view as scroll indicator
   if (scrollView.contentOffset.x == 0) {
        _dragableView.frame = CGRectMake(_dragableView.bounds.origin.x+21
                                         - scrollView.contentOffset.x/2, 89, 120, 2);
    }else{
        _dragableView.frame = CGRectMake(_dragableView.bounds.origin.x+21
                                         + scrollView.contentOffset.x/2, 89, 120, 2);
    }
    scrollDirectionDetermined = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollDirectionDetermined = NO;
}
-(void)dismissKeyboard {

    [self.view endEditing:true];
}
# pragma mark - keyboard movements
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //email field
    if (textField.tag == 1) {
        _imageTopConstraints.constant= -80;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //password field
    else if (textField.tag == 2){
         _imageTopConstraints.constant = -60;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
     //corporateId text  field
    else if (textField.tag == 3){
        _slideImageTopConstraints.constant = -120;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
     //business user mobile number text field
    else if (textField.tag == 4){
        _slideImageTopConstraints.constant = -110;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
     //business user password field
    else if (textField.tag == 5){
        _slideImageTopConstraints.constant = -100;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
     _imageTopConstraints.constant = 40;
     _slideImageTopConstraints.constant = 40;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
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
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"2"]) {
                
               // [self showBasicAlert:[responseDict objectForKey:@"message"] Message:nil];
                  NSDictionary *dataDictionary = [responseDict valueForKey:@"data"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dataDictionary valueForKey:@"user_id"] forKey:@"logged_user_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dataDictionary valueForKey:@"case_id"] forKey:@"logged_case_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dataDictionary valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dataDictionary valueForKey:@"groups_id"] forKey:@"logged_groups_id"];
                
                NSLog(@"%@%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"],[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"]);
               
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"confirmOtpScreen"];
                [self presentViewController:vc animated:YES completion:nil];
                
            }

            if ([[responseDict objectForKey:@"code"] isEqualToString:@"1"]){
                 
                  //userInfoFromResponse = [responseDict objectForKey:@"data"];
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];

                 // NSLog(@"info -%@",userInfoFromResponse);
                NSMutableDictionary * dictWithUserSessionLogininfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[responseDict objectForKey:@"data"] objectForKey:@"user_id"],@"user_id",[[responseDict objectForKey:@"data"] objectForKey:@"user_security_hash"],@"user_security_hash", nil];
               
                // store userID and Security hash
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"groups_id"] forKey:@"logged_groups_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_email"] forKey:@"logged_user_email"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_name"] forKey:@"logged_user_name"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"case_type"] forKey:@"logged_case_type"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"case_title"] forKey:@"logged_case_title"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"case_court_name"] forKey:@"logged_case_court_name"];
                
               
//                NSLog(@"------- %@%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_case_search_in"],[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_case_search_period"]);
                [[NSUserDefaults standardUserDefaults] setObject:dictWithUserSessionLogininfo forKey:@"SessionLogininfo"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
                
                }
           }
    }]; // login api end
}
    //A basic alert showing method
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
 #pragma segue methods
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"LoginSuccessful"]) {
//        SWRevealViewController *vc = (SWRevealViewController *)segue.destinationViewController;
//        vc.userInfo = userInfoFromResponse;
//    }
//}
-(IBAction)unwindToLoginScreen:(UIStoryboardSegue*)segue{
    
}
- (IBAction)loginButtonActionForBusinessUser:(id)sender {
     [dictWithCorporateIdAndMobileNumberAndPassword setObject:_corporateIdTextField.text forKey:@"corporation_id"];
    [dictWithCorporateIdAndMobileNumberAndPassword setObject:_businessUserMobileNumberTextField.text forKey:@"user_login"];
    [dictWithCorporateIdAndMobileNumberAndPassword setObject:_businessUserPasswordTextField.text forKey:@"user_login_password"];
   
    //check user on server to login
    [RequestManager getFromServer:@"login" parameters:dictWithCorporateIdAndMobileNumberAndPassword completionHandler:^(NSDictionary *responseDict) {
        
        
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
                
//               userInfoFromResponse = [responseDict objectForKey:@"data"];
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
              //  NSLog(@"info -%@",userInfoFromResponse);
                NSMutableDictionary * dictWithUserSessionLogininfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[responseDict objectForKey:@"data"] objectForKey:@"user_id"],@"user_id",[[responseDict objectForKey:@"data"] objectForKey:@"user_security_hash"],@"user_security_hash", nil];
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"groups_id"] forKey:@"logged_groups_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_email"] forKey:@"logged_user_email"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_name"] forKey:@"logged_user_name"];
                
                [[NSUserDefaults standardUserDefaults] setObject:dictWithUserSessionLogininfo forKey:@"SessionLogininfo"];
                [[NSUserDefaults standardUserDefaults]synchronize];
               
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"master user"];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }]; // login api end
}
- (IBAction)forgotPasswordButtonAction:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"confirm mobile"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)notAUserButtonAction:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"register screen"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
