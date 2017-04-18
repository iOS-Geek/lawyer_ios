//
//  AddCommentViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 29/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AddCommentViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
static NSString *kDescriptionPlaceHolder = @"Comments";
@interface AddCommentViewController ()<UITextFieldDelegate ,UITextViewDelegate>
{
     NSMutableDictionary *dictWithStartDateAndAddComment;
     UIColor *clearColor;
     UIColor *lightCyanColor;
     UILabel *placeholderLable;
}
@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    _addCommentTextView.delegate = self;
    _nextDateTextField.delegate = self;
    
    dictWithStartDateAndAddComment = [[NSMutableDictionary alloc]init];
    
    lightCyanColor = [UIColor colorWithRed:69/255.0 green:174/255.0 blue:202/255.0 alpha:1];
    clearColor =  [UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1];
    
    // Date Picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    _nextDateTextField.inputView = datePicker;
    
    // default date
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    [_nextDateTextField setPlaceholder:[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]]];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    [toolBar setBarTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *flexButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(updateText:)];
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton1, doneButton, nil];
    
    [toolBar setItems:itemsArray];
    doneButton.tintColor=[UIColor blackColor];
    
    _nextDateTextField.inputAccessoryView = toolBar;
   
    
    placeholderLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,_addCommentTextView.frame.size.width - 10.0, 34.0)];
    
    
    [placeholderLable setText:kDescriptionPlaceHolder];
    [placeholderLable setBackgroundColor:[UIColor clearColor]];
    [placeholderLable setTextColor:[UIColor lightGrayColor]];
    _addCommentTextView.delegate = self;
    
    [_addCommentTextView addSubview:placeholderLable];
    
}
- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    if (![_addCommentTextView hasText]) {
        placeholderLable.hidden = NO;
    }
}
-(void) textViewDidChange:(UITextView *)textView
{
    
    if(![textView hasText]) {
        placeholderLable.hidden = NO;
    }
    else{
        placeholderLable.hidden = YES;
    }
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    _addCommentTextViewHeightConst.constant = newSize.height;
    [self.view layoutIfNeeded];
}

- (void)touchesBegan:(NSSet<UITouch * >* )touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.view endEditing:true];
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma Date Picker
-(void)updateText:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.nextDateTextField.inputView;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
   
        _nextDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:picker.date]];
        _nextDateTextField.tintColor = [UIColor clearColor];
        [_nextDateTextField resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
       
        [_addCommentTextView becomeFirstResponder];
    }

    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    if([_nextDateTextField isFirstResponder]){
        [_addCommentView setBackgroundColor:clearColor];
        [_nextDateView setBackgroundColor:lightCyanColor];
    }
  
    
} // Text View Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
     if([_addCommentTextView isFirstResponder]){
        [_nextDateView setBackgroundColor:clearColor];
        [_addCommentView setBackgroundColor:lightCyanColor];
    }
}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    
////    if ([_addCommentTextView.text length] > 0) {
////        [_addCommentTextView setBackgroundColor:[UIColor whiteColor]];
////        [self.placeholderLable setHidden:YES];
////    } else {
////        
////        [_addCommentTextView setBackgroundColor:[UIColor clearColor]];
////        [self.placeholderLable setHidden:NO];
////    }
//
//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    _addCommentTextViewHeightConst.constant = newSize.height;
//    [self.view layoutIfNeeded];
//
//}

- (IBAction)addCommentButtonAction:(id)sender {

     dictWithStartDateAndAddComment = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_security_hash"],@"user_security_hash",[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_case_id"],@"case_id",_nextDateTextField.text,@"case_next_date",_addCommentTextView.text,@"case_detail_comment", nil];
    
    [RequestManager getFromServer:@"add_comment" parameters:dictWithStartDateAndAddComment completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
            [self showBasicAlert:@"No Network Availbale!!!" Message:@"Please connect to a working internet."];
            return ;
        }
        else{
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"0"]) {
                [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                return;
            }
            
            if ([[responseDict objectForKey:@"code"] isEqualToString:@"1"]) {
               //   [self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                 NSLog(@" add comment status %@",responseDict);
                
                
            //  [self performSegueWithIdentifier:@"add comment" sender:self];
           //     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          //      SWRevealViewController *viewController = (SWRevealViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
//                
         //       [self presentViewController:viewController animated:YES completion:nil];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
                [self presentViewController:vc animated:YES completion:nil];

            
            }
        }
    }]; //add comment api ends
}
  #pragma alert methods
 -(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
   
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)backButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
     [self presentViewController:vc animated:YES completion:nil];
}
@end
