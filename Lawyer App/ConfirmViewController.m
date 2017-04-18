//
//  ConfirmViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "ConfirmViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface ConfirmViewController ()<UITextFieldDelegate>
{
    NSMutableDictionary *userInfoFromResponse;
    NSMutableDictionary *sampleDict;
    NSMutableString * str1;
    NSMutableString *str2;
}
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [_mobileNumberTextField setValue:[UIColor whiteColor]  forKeyPath:@"_placeholderLabel.textColor"];
  
    // text field delegate
      _mobileNumberTextField.delegate = self;
    
     str1 = [[NSMutableString alloc]init];
     str2 = [[NSMutableString alloc]init];
    
    _clickedDone.returnKeyType = UIReturnKeyDone;
    
   // NSLog(@"my info :%@", _userInfoToRecive);
   
}
# pragma text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        if(textField.tag == 1){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    } 
       return YES;
}
- (void)touchesBegan:(NSSet<UITouch * >* )touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.view endEditing:true];
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}
- (IBAction)confirmButtonAction:(id)sender {
   
    NSLog(@" user id - %@",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"]);
    
 // str1 =[NSMutableString stringWithFormat:@"%@", [_userInfoToRecive objectForKey:@"user_id"]];
  //  str2 =[NSMutableString stringWithFormat:@"%@", [_userInfoToRecive objectForKey:@"user_security_hash"]];
    
    
    
    sampleDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash",_mobileNumberTextField.text,@"user_otp", nil];
    NSLog(@"%@", sampleDict);
    
    [RequestManager getFromServer:@"verify_otp" parameters:sampleDict completionHandler:^(NSDictionary *responseDict) {
        
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
            //  [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_otp"] forKey:@"logged_user_otp"];
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"otp_Verification_Done"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"otp_Verification_Done"];
                [self performSegueWithIdentifier:@"otp verified " sender:self];
            }
        }
    }];//  verify_otp api ends
}
#pragma segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"otp verified "]) {
        //pass info to next screen
        LoginViewController *vc = (LoginViewController *)segue.destinationViewController;
        vc.userInfo = sampleDict;
              }
}
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
- (IBAction)notRecivedYetButtonAction:(id)sender {
//    str1 =[NSMutableString stringWithFormat:@"%@", [_userInfoToRecive objectForKey:@"user_id"]];
//    str2 =[NSMutableString stringWithFormat:@"%@", [_userInfoToRecive objectForKey:@"user_security_hash"]];
    
    
    sampleDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash", nil];
    NSLog(@"%@", sampleDict);
    [RequestManager getFromServer:@"resend_otp" parameters:sampleDict completionHandler:^(NSDictionary *responseDict) {
        
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
                
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_otp"] forKey:@"logged_user_otp"];
            }
        }
    }];// resend_otp api ends
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
