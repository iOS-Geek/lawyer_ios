//
//  EditProfileViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *userLocationTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong , nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;

- (IBAction)sideBarButtonAction:(id)sender;
- (IBAction)submitButtonAction:(id)sender;
@end
