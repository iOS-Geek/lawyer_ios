//
//  HomeViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 24/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "HomeViewController.h"
//#import "SWRevealViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      //self.navigationController.navigationBar.hidden = YES;
      _addButtonImage.layer.cornerRadius = 30;
    //  _addButtonImage.layer.cornerRadius = self.addButtonImage.frame.size.width/2;
        _addButtonImage.clipsToBounds = YES;
    
    
//   _sidebarButton.target = self.revealViewController;
//   _sidebarButton.action = @selector(revealToggle:);
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.sidebarButton setTarget: self.revealViewController];
//        [self.sidebarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//        
//    }
    
    
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

- (IBAction)sidebarButton:(id)sender {
   // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}
@end
