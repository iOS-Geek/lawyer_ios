//
//  confirmMobileNumberViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 12/12/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "confirmMobileNumberViewController.h"
#import "RequestManager.h"
#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface confirmMobileNumberViewController ()
{
    NSMutableDictionary * mobileNumber;

}
@end

@implementation confirmMobileNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mobileNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _clickedDone.returnKeyType = UIReturnKeyDone;
     _mobileNumberTextField.delegate = self;
    mobileNumber = [[NSMutableDictionary alloc]init];
    _userInfo = [[NSMutableDictionary alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard {
    
    [self.view endEditing:true];
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
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmButtonAction:(id)sender {
     [mobileNumber setObject:_mobileNumberTextField.text forKey:@"user_contact"];
    [_userInfo addEntriesFromDictionary: mobileNumber];
    [RequestManager getFromServer:@"forgot_password" parameters:_userInfo completionHandler:^(NSDictionary *responseDict) {
        
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
//                 [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                NSLog(@" forget password status %@",responseDict);
                
//                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
//                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
//                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                
                [self performSegueWithIdentifier:@"login screen" sender:self];
            }
        }
    }]; //forgot password api ends
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
