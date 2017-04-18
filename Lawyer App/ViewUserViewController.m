//
//  ViewUserViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 13/01/17.
//  Copyright © 2017 Paramjeet Kaur. All rights reserved.
//

#import "ViewUserViewController.h"

@interface ViewUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (IBAction)backButtonAction:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"master user"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
