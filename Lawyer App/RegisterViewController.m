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
    _clickedDone.returnKeyType = UIReturnKeyDone;
    
    _userNameTextField.delegate = self;
    _mobileNumberTextField.delegate = self;
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    _confirmPasswordtextField.delegate = self;
    
    dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword= [[NSMutableDictionary alloc]init];
    
    //store response from server
    userInfoFromResponse = [[NSMutableDictionary alloc]init];
    _userInfo= [[NSMutableDictionary alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    [self.view addGestureRecognizer:tap];
    
}
# pragma Textfield Delegate METHODS

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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //user name text field
    if (textField.tag == 1) {
        _registerButtonBottomConst.constant = 266;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _registerButtonBottomConst.constant = 290;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    //mobile number field
    else if (textField.tag == 2){
        _registerButtonBottomConst.constant = 230;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _registerButtonBottomConst.constant = 244;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    // email text field
    else if (textField.tag == 3){
        _registerButtonBottomConst.constant = 194;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _registerButtonBottomConst.constant = 198;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    // password text field
    else if (textField.tag == 4){
        _registerButtonBottomConst.constant = 158;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _registerButtonBottomConst.constant = 160;
        }
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    // confirm password field
    else {
        _registerButtonBottomConst.constant = 122;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            _registerButtonBottomConst.constant = 124;
        }
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

- (IBAction)registorButtonAction:(id)sender {
    [  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_userNameTextField.text forKey:@"user_name"];
    [  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_emailTextField.text forKey:@"user_email"];
    [  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_mobileNumberTextField.text forKey:@"user_contact"];
    [  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_passwordTextField.text forKey:@"user_login_password"];
    [  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword setObject:_confirmPasswordtextField.text forKey:@"confirm_login_password"];
    
    [_userInfo addEntriesFromDictionary:  dictWithNameAndUserMobileNumberAndEmailAndPasswordAndConfirmPassword];
    
    
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
                NSLog(@" signup status %@", responseDict);
          //   [self performSegueWithIdentifier:@"confirm screen" sender:self];
            }
        }
    }];//sign api ends

}
#pragma segue methods
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([[segue identifier] isEqualToString:@"confirm screen"]) {
//        //pass info to next screen
//        ConfirmViewController *vc = (ConfirmViewController *)segue.destinationViewController;
//        vc.userInfo = _userInfo;
//    }
//}
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
