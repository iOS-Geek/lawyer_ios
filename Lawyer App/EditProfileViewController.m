//
//  EditProfileViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "EditProfileViewController.h"
#import "SWRevealViewController.h"
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
     [_userSpecialisationTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    _userNameTextField.delegate = self;
    _emailTextField.delegate = self;
    _stateTextField.delegate = self;
    _userLocationTextField.delegate = self;
    _userSpecialisationTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    self.navigationController.navigationBar.hidden = YES;
}
-(void)dismissKeyboard {
    
    [self.view endEditing:true];
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
        [_userSpecialisationTextField becomeFirstResponder];
    }
    else if (textField.tag == 5) {
        [_userSpecialisationTextField resignFirstResponder];
    }
    return YES;
}
#pragma mark - keyboard movements
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //name field
    if (textField.tag == 1) {
        _imageTopConstraint.constant= -151;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //email  field
    else if (textField.tag == 2){
        _imageTopConstraint.constant = -148;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //state  field
    else if (textField.tag == 3){
        _imageTopConstraint.constant = -145;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    //location field
    else if (textField.tag == 4){
        _imageTopConstraint.constant = -142;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }
    else if (textField.tag == 5){
        _imageTopConstraint.constant = -140;
        [_scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.2 animations:^{
            [_scrollView layoutIfNeeded];
        }];
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _imageTopConstraint.constant = 2;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitButtonAction:(id)sender {
}
@end
