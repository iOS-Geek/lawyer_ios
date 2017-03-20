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
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordtextField;
@property (strong, nonatomic)  NSLayoutConstraint *registerButtonBottomConst;
@property (weak, nonatomic)  NSLayoutConstraint *contentViewTopConst;
- (IBAction)registorButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *registerScreenView;
@property (nonatomic, retain)  UITextField *clickedDone;
@end
