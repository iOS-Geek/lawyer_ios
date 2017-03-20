//
//  ConfirmViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "ConfirmViewController.h"

@interface ConfirmViewController ()
{
    NSMutableDictionary *userInfoFromResponse;
    NSMutableDictionary * userMobileNumber;
}
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userInfoFromResponse = [[NSMutableDictionary alloc]init];
    userMobileNumber = [[NSMutableDictionary alloc]init];
   
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
   
    [userMobileNumber setObject:_mobileNumberTextField.text forKey:@"user_contact"];
    [RequestManager getFromServer:@"login" parameters:userMobileNumber   completionHandler:^(NSDictionary *responseDict) {
           if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
            [self showBasicAlert:@"No Network Available!!!" Message:@"User Registered!! Please Login now."];
            return ;
        }
         if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]){
            
            NSDictionary *dataDict = [responseDict valueForKey:@"data"];
            
    

            
       
    // [self performSegueWithIdentifier:@"UserRegistered" sender:self];
     }
   }];
}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
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
@end
