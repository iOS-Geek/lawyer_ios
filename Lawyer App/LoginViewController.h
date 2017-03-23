//
//  LoginViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestManager.h"
#import "HomeViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak ,nonatomic) NSMutableDictionary *userInfo;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonAction:(id)sender;

@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *corporateIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *businessUserMobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *businessUserPasswordTextField;

@end
