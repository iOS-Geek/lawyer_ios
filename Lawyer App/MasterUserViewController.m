//
//  MasterUserViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 11/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import "MasterUserViewController.h"
#import "SWRevealViewController.h"
@interface MasterUserViewController ()

@end

@implementation MasterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:)
//          forControlEvents:UIControlEventTouchUpInside];
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)viewUserButtonAction:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"active or inactive"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)viewCasesButtonAction:(id)sender {
}

- (IBAction)addCaseButtonAction:(id)sender {
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"addCaseScreen"];
    [self presentViewController:vc animated:YES completion:nil];
 }
@end
