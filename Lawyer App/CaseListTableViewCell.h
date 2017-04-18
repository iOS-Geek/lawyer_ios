//
//  CaseListTableViewCell.h
//  Lawyer App
//
//  Created by iOS Developer on 24/12/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *caseHearingDateLable;
@property (weak, nonatomic) IBOutlet UILabel *caseTitleLable;

@end
