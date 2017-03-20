//
//  CaseListViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 30/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "CaseListViewController.h"

@interface CaseListViewController ()

@end

@implementation CaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _addButtonImage.layer.cornerRadius = 30;
    _addButtonImage.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
