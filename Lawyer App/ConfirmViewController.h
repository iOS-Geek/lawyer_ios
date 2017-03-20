//
//  ConfirmViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestManager.h"
@interface ConfirmViewController : UIViewController
@property (nonatomic,weak) NSMutableDictionary *userInfo;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
- (IBAction)confirmButtonAction:(id)sender;
@end
