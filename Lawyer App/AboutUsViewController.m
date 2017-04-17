//
//  AboutUsViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 14/12/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
