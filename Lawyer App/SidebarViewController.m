//
//  SidebarViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 24/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "ChangePasswordViewController.h"
#import "AddCaseViewController.h"
@interface SidebarViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuItems;
    NSMutableDictionary *myDictionary;
    int screenCheck;
}

@end

@implementation SidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
     NSLog(@" my Dictionary - %@" ,_userInfo);
     menuItems = @[@"Home", @"About Us", @"Add Case", @"Change Password", @"Logout", @"ShareApp", @"Edit Profile", @"View Users", @"Case Status", @"Settings"];
     myDictionary = [[NSMutableDictionary alloc]init];
    
    
  }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       
    return cell;
}
- (void) tableView:(UITableView* )tableView didSelectRowAtIndexPath:(NSIndexPath* )indexPath{
    if(indexPath.row == 0){
        if (screenCheck == 0) {
            [self.revealViewController revealToggleAnimated:true];
            return;
        }
        
        screenCheck = 0;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       
        
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"homeScreen"];
        [self.revealViewController setFrontViewController:vc];
        [self.revealViewController revealToggleAnimated:true];

    
    }
    if (indexPath.row == 1) {
        if (screenCheck == 1) {
            [self.revealViewController revealToggleAnimated:true];
            return;
        }
        
        screenCheck = 1;
        // Get a reference to the storyboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //session login api run
        
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"aboutUsScreen"];
        [self.revealViewController setFrontViewController:vc];
        [self.revealViewController revealToggleAnimated:true];
    }
//    else if (indexPath.row == 2) {
//        if (screenCheck == 2) {
//            [self.revealViewController revealToggleAnimated:true];
//            return;
//        }
//        
//        screenCheck = 2;
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        //session login api run
//        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addCaseScreen"];
//        [self.revealViewController setFrontViewController:vc];
//        [self.revealViewController revealToggleAnimated:true];
//    }
    else if (indexPath.row == 3) {
        if (screenCheck == 3) {
            [self.revealViewController revealToggleAnimated:true];
            return;
        }
        
        screenCheck = 3;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //session login api run
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"changePassword"];
        [self.revealViewController setFrontViewController:vc];
        [self.revealViewController revealToggleAnimated:true];
    
        }
    else if (indexPath.row ==5) {
        NSString *shareText = [NSString stringWithFormat:@"Text to share"];
        NSArray *shareObject = @[shareText];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:shareObject applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    else if (indexPath.row == 6) {
        if (screenCheck == 6) {
            [self.revealViewController revealToggleAnimated:true];
            return;
        }
        
        screenCheck = 6;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"editProfile"];
        [self.revealViewController setFrontViewController:vc];
        [self.revealViewController revealToggleAnimated:true];
        
    }
    else if (indexPath.row ==9) {
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"] options:@{} completionHandler:nil];
        
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"change password"]) {
//        UINavigationController *navController = segue.destinationViewController;
//        ChangePasswordViewController *ChangePassword = [navController childViewControllers].firstObject;
//        [myDictionary addEntriesFromDictionary:_userInfo];
//        ChangePassword.infoToPass = myDictionary;
//    }
//    
if ([segue.identifier isEqualToString:@"add case"]) {
        UINavigationController *navController = segue.destinationViewController;
        AddCaseViewController *addCase = [navController childViewControllers].firstObject;
        [myDictionary addEntriesFromDictionary:_userInfo];
        addCase.infoToPass = myDictionary;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    else {
        return 35;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
