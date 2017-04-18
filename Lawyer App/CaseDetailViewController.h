//
//  CaseDetailViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *messageButtonImage;
- (IBAction)backButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property(strong)  NSMutableDictionary *userCaseInfoDict;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseNumberViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseTitleViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *judgenameViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseStatusViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *satartDateViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retainedViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contectViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oppositeCounselHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oppositeCounselContectViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseTypeViewHeightConst;



@property (weak, nonatomic) IBOutlet UILabel *caseNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *judgeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retainedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *retainedContectLabel;
@property (weak, nonatomic) IBOutlet UILabel *oppositeCounselNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oppositeCounselContectLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseTypeLabel;
@property (weak, nonatomic) IBOutlet UITableView *caseDetailTable;

- (IBAction)addCommentButtonActon:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *messageButtonView;
- (IBAction)emailVarificationButtonAction:(id)sender;
@end
