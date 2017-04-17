//
//  ChangePasswordViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *changedPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
- (IBAction)submitButtonAction:(id)sender;
@property (weak ,nonatomic) NSMutableDictionary * infoToPass;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;


@end
