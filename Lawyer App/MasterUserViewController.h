//
//  MasterUserViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 11/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterUserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *menuButton;


- (IBAction)viewUserButtonAction:(id)sender;
- (IBAction)viewCasesButtonAction:(id)sender;
- (IBAction)addCaseButtonAction:(id)sender;


@end
