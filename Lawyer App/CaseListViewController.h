//
//  CaseListViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 30/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *addButtonImage;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addCaseButtonAction:(id)sender;

@end
