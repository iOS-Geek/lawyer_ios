//
//  EditProfileViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()<UITextFieldDelegate>

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [_userNameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_emailTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_stateTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_userLocationTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    _userNameTextField.delegate = self;
    _emailTextField.delegate = self;
    _stateTextField.delegate = self;
    _userLocationTextField.delegate = self;
    
    self.navigationController.navigationBar.hidden = YES;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [_emailTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_stateTextField becomeFirstResponder];
    }
    else if (textField.tag == 3) {
        [_userLocationTextField becomeFirstResponder];
    }
    else if (textField.tag == 4) {
        [_userLocationTextField resignFirstResponder];
    }
    return YES;
}
#pragma mark - keyboard movements
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //name field
    if (textField.tag == 1) {
        _imageTopConstraint.constant= -150;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //email  field
    else if (textField.tag == 2){
        _imageTopConstraint.constant = -145;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //state  field
    else if (textField.tag == 3){
        _imageTopConstraint.constant = -140;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //location field
    else if (textField.tag == 4){
        _imageTopConstraint.constant = -130;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _imageTopConstraint.constant = 20;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sideBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitButtonAction:(id)sender {
}
@end
