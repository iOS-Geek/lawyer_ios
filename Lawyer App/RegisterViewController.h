//
//  RegisterViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestManager.h"
#import "ConfirmViewController.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property (strong)   NSMutableDictionary *userInfo;
@property (strong)   NSMutableDictionary *userInfoToPass;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordtextField;

- (IBAction)registorButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong , nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;



- (IBAction)backButtonAction:(id)sender;

@end
