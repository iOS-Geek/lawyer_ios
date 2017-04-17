//
//  AddCommentViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AddCommentViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
@interface AddCommentViewController ()<UITextFieldDelegate>
{
    NSMutableDictionary *dictWithStartDateAndAddComment;

}
@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addCommentTextField.delegate = self;
    _nextDateTextField.delegate = self;
    
    dictWithStartDateAndAddComment = [[NSMutableDictionary alloc]init];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [_addCommentTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_addCommentTextField resignFirstResponder];
        
     }
    return YES;
}
- (IBAction)addCommentButtonAction:(id)sender {
//    [startDateAndAddComment setObject:_nextDateTextField.text forKey:@"case_next_date"];
//    [startDateAndAddComment setObject:_addCommentTextField.text forKey:@"case_detail_comment"];
  dictWithStartDateAndAddComment = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"383" ,@"user_id",@"994e54f2ee912d46e7d29324ba5247d6",@"user_security_hash",@"347",@"case_id",_nextDateTextField.text,@"case_next_date",_addCommentTextField.text,@"case_detail_comment", nil];
    
    [RequestManager getFromServer:@"add_comment" parameters:dictWithStartDateAndAddComment completionHandler:^(NSDictionary *responseDict) {
        
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
                NSLog(@" forget password status %@",responseDict);
                
             //  [self performSegueWithIdentifier:@"login screen" sender:self];
            }
        }
    }]; //forgot password api ends
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

@end
