//
//  AddCaseViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kDescriptionPlaceHolder = @"Comments";
@interface AddCaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property (weak ,nonatomic) NSMutableDictionary * infoToPass;

@property (weak, nonatomic) IBOutlet UILabel *caseTypeLable;

@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *previousDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *popUpCaseTypeTextField;


@property (weak, nonatomic) IBOutlet UITextField *judgeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseStatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *nextDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseRetainedNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseReatainedContectTextField;
@property (weak, nonatomic) IBOutlet UITextField *oppositeCounselNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *oppositeCounselContectTextField;
@property (weak, nonatomic) IBOutlet UITextView *addCommentTextView;


- (IBAction)addCaseButtonAction:(id)sender;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startDateHeightConst;


@property (weak, nonatomic) IBOutlet UIView *startDateView;
@property (weak, nonatomic) IBOutlet UIView *previousDateView;
@property (weak, nonatomic) IBOutlet UIView *caseTitleView;
@property (weak, nonatomic) IBOutlet UIView *judgeNameView;
@property (weak, nonatomic) IBOutlet UIView *caseNumberView;
@property (weak, nonatomic) IBOutlet UIView *caseStatusView;
@property (weak, nonatomic) IBOutlet UIView *nextDateView;
@property (weak, nonatomic) IBOutlet UIView *retainedView;
@property (weak, nonatomic) IBOutlet UIView *mobileNumberView;
@property (weak, nonatomic) IBOutlet UIView *oppositeCounselView;
@property (weak, nonatomic) IBOutlet UIView *oppositeCounselMobileNumberView;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UIView *popUpCaseTypeView;


@property (weak, nonatomic) IBOutlet UIView *hideAndShowView;


- (IBAction)backButtonAction:(id)sender;






@end
