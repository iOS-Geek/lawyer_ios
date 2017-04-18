//
//  AboutUsViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 14/12/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import <MessageUI/MessageUI.h> 
//#import <MessageUI/MFMailComposeViewController.h>

@interface AboutUsViewController ()<MFMailComposeViewControllerDelegate,UIAlertViewDelegate>

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)popUpViewButtonAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contact Us"  message:@""  preferredStyle:UIAlertControllerStyleAlert];
    
    // calling Action
    UIAlertAction* phoneNumber = [UIAlertAction actionWithTitle:@"+919988726189"   style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString *phNo = @"+919988726189";
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            UIApplication *application = [UIApplication sharedApplication];
            [application openURL:phoneUrl options:@{} completionHandler:nil];
        }
 
}];
    
    // Email Action
    UIAlertAction* email = [UIAlertAction actionWithTitle:@"support@viableweblog.com"   style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        if([MFMailComposeViewController canSendMail] ) {
            
            mailController.mailComposeDelegate = self;
            [mailController setSubject:@"Email"];
            [mailController setMessageBody:@"Don't ever want to give you up" isHTML:NO];
            [mailController setToRecipients:[NSArray arrayWithObject:@"support@test.com"]];
            
             [self presentViewController:mailController animated:YES completion:NULL];
           
        }
    }];
  
     // cancel button
      UIAlertAction* Cancle = [UIAlertAction actionWithTitle:@"cancel"  style:UIAlertActionStyleCancel handler:nil];
      [alertController addAction:phoneNumber];
      [alertController addAction:email];
      [alertController addAction:Cancle];
    
    
     [self presentViewController:alertController animated:YES completion:nil];
   
}
#pragma mark - mail compose delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
