//
//  AddCaseViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property (weak ,nonatomic) NSMutableDictionary * infoToPass;


@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *previousDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *judgeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseStatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *nextDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseRetainedNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseReatainedContectTextField;
@property (weak, nonatomic) IBOutlet UITextField *oppositeCounselNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *oppositeCounselContectTextField;
@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;

- (IBAction)addCaseButtonAction:(id)sender;

@property (strong , nonatomic) IBOutlet NSLayoutConstraint *startDateLableTopConstraint;
- (IBAction)backButtonAction:(id)sender;
@end
