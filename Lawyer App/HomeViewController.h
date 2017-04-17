//
//  HomeViewController.h
//  Lawyer App
//
//  Created by iOS Developer on 24/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "SWRevealViewController.h"
@interface HomeViewController : UIViewController<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>

@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;

@property (nonatomic,weak) NSMutableDictionary *userInfo;
@property (weak, nonatomic) IBOutlet UIImageView *addButtonImage;

@property (strong)  NSMutableDictionary *caseInfoToRecive;



//- (IBAction)buttonAction:(id)sender;

@end
