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
@property (strong , nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraints;
- (IBAction)loginButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *dragableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)loginButtonActionForBusinessUser:(id)sender;
@property (strong , nonatomic) IBOutlet NSLayoutConstraint *slideImageTopConstraints;
@property (weak, nonatomic) IBOutlet UITextField *corporateIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *businessUserMobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *businessUserPasswordTextField;

//@property (nonatomic, strong)  UIButton *animationOption1;
@property (nonatomic, assign) UIViewAnimationOptions animation1;
@property (nonatomic, assign) BOOL animationInProgress;




- (IBAction)forgotPasswordButtonAction:(id)sender;
- (IBAction)notAUserButtonAction:(id)sender;
@end
