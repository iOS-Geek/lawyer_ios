//
//  confirmMobileNumberViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 12/12/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestManager.h"
@interface confirmMobileNumberViewController : UIViewController<UITextFieldDelegate>
@property (strong)   NSMutableDictionary *userInfo;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (nonatomic, retain)  UITextField *clickedDone;
- (IBAction)confirmButtonAction:(id)sender;

- (IBAction)backButtonAction:(id)sender;

@end
