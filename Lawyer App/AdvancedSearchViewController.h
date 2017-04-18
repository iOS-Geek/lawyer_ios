//
//  AdvancedSearchViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 13/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedSearchViewController : UIViewController


- (IBAction)backButtonAction:(id)sender;
- (IBAction)searchButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *dropDownTextField;

- (IBAction)weaklyButtonAction:(id)sender;
- (IBAction)allButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
