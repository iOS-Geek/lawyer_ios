//
//  ChangePasswordViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "RequestManager.h"
#import "AppDelegate.h"
@interface ChangePasswordViewController ()<UITextFieldDelegate>

{
    NSMutableDictionary *dictWithUserNewPasswordAndConfirmPassword;
    NSMutableDictionary *responseMessageDict;
    NSMutableDictionary *myDict;
   
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _changedPasswordTextField.delegate = self;
    _confirmPasswordTextField.delegate = self;
    
    [_changedPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_confirmPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    dictWithUserNewPasswordAndConfirmPassword = [[NSMutableDictionary alloc]init];
   // responseMessageDict = [[NSMutableDictionary alloc]init];
    myDict = [[NSMutableDictionary alloc]init];
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [_confirmPasswordTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_confirmPasswordTextField resignFirstResponder];
    }

    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        if(textField.tag == 1){
        
        [_changedPasswordTextField setSecureTextEntry:YES];
    }
    if(textField.tag == 2){
        
        [_confirmPasswordTextField setSecureTextEntry:YES];
    }
     return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitButtonAction:(id)sender {
//parameters for hitting api
//    "user_id" = 383;
//    "user_security_hash" = 2361f1a2873fb180455546fb2d8f1606;
    [dictWithUserNewPasswordAndConfirmPassword setObject:@" 383" forKey:@"user_id"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:@" 5a2e309a0d0d04f11aaacb7707cc3c2b" forKey:@"user_security_hash"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:_changedPasswordTextField.text forKey:@"user_login_password"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:_confirmPasswordTextField.text forKey:@"confirm_login_password"];
   
    [myDict addEntriesFromDictionary:dictWithUserNewPasswordAndConfirmPassword];
    [RequestManager getFromServer:@"change_password" parameters:myDict completionHandler:^(NSDictionary *responseDict) {
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
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                //Save user information in local
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                
                [self performSegueWithIdentifier:@"passwordUpdated" sender:self];
            }
        }
    }];//change password api ends
}

//A basic alert showing method
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
