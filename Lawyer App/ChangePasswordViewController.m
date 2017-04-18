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
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
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
    
    //NSLog(@"%@", _infoToPass);
    self.navigationController.navigationBar.hidden = YES;
    
    _changedPasswordTextField.delegate = self;
    _confirmPasswordTextField.delegate = self;
    
    

    
    [_changedPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_confirmPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    dictWithUserNewPasswordAndConfirmPassword = [[NSMutableDictionary alloc]init];
      myDict = [[NSMutableDictionary alloc]init];
    
    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

   
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
    
    [dictWithUserNewPasswordAndConfirmPassword setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] forKey:@"user_id"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"] forKey:@"user_security_hash"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:_changedPasswordTextField.text forKey:@"user_login_password"];
    [dictWithUserNewPasswordAndConfirmPassword setObject:_confirmPasswordTextField.text forKey:@"confirm_login_password"];
   
    [myDict addEntriesFromDictionary:dictWithUserNewPasswordAndConfirmPassword];
    NSLog(@" change password - %@",myDict);
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
                 [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                //Save user information in local
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                
               
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"homeScreen"];
                [self.revealViewController setFrontViewController:vc];
                [self.revealViewController revealToggleAnimated:true];

            }
        }
    }];//change password api ends
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
@end
