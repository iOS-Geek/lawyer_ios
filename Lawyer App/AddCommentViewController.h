//
//  AddCommentViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nextDateTextField;
@property (weak, nonatomic) IBOutlet UITextView *addCommentTextView;


- (IBAction)addCommentButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *nextDateView;
@property (weak, nonatomic) IBOutlet UIView *addCommentView;

- (IBAction)backButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addCommentTextViewHeightConst;


@end
