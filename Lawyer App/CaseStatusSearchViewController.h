//
//  CaseStatusSearchViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 13/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseStatusSearchViewController : UIViewController

- (IBAction)backButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *caseStatusSearchTextField;
- (IBAction)caseStatusSearchButtonAction:(id)sender;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseTypeView;

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property(strong) NSArray*userInfo;
@property (strong) NSString *stringToAdd;

- (IBAction)caseTypeButtonAction:(id)sender;
- (IBAction)caseTitleButtonAction:(id)sender;
- (IBAction)judgeNameButtonAction:(id)sender;
- (IBAction)weaklyButtonAction:(id)sender;
- (IBAction)allButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *caseTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *caseTitleButton;
@property (weak, nonatomic) IBOutlet UIButton *judgeNameButton;
@property (weak, nonatomic) IBOutlet UIButton *weaklyButton;
@property (weak, nonatomic) IBOutlet UIButton *allButton;

@end
