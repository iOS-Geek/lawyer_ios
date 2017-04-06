//
//  HomeViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 24/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "AddCaseViewController.h"
@interface HomeViewController ()
{
    NSMutableDictionary * infoToPass;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.navigationController.navigationBar.hidden = YES;
    
     _addButtonImage.layer.cornerRadius = 30;
    //  _addButtonImage.layer.cornerRadius = self.addButtonImage.frame.size.width/2;
        _addButtonImage.clipsToBounds = YES;
    
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:)
         forControlEvents:UIControlEventTouchUpInside];
     [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    NSLog(@"my add case info - %@",_caseInfoToRecive);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
- (IBAction)addCaseButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"add case view" sender:self];
}

//- (IBAction)sideBarButtonAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
@end
