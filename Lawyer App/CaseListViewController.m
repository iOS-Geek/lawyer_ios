//
//  CaseListViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 30/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "CaseListViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
//#import "TableViewCell.h"
@interface CaseListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   
    NSMutableDictionary *myDict;
    NSMutableDictionary *caseInfo;
    NSMutableArray *dictAllKeys;
 
}
@end

@implementation CaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _addButtonView.layer.cornerRadius =self.addButtonView.frame.size.width/2;
    _addButtonView.clipsToBounds = YES;
   
    myDict = [[NSMutableDictionary alloc]init];
    caseInfo = [[NSMutableDictionary alloc]init];
  
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return dictAllKeys.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text =[[dictAllKeys objectAtIndex:indexPath.row] objectForKey:@"case_title"];
    return cell;
}

//-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:okAction];
//    [self presentViewController:alert animated:YES completion:nil];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCaseButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"add cases" sender:self];
}
@end
