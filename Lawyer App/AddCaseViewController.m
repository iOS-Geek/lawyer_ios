//
//  AddCaseViewController.m
//  Lawyer App
//
//  Created by iOS Developer on 28/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AddCaseViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "HomeViewController.h"
#define ACCEPTABLE_CHARECTERS @"0123456789"
@interface AddCaseViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    NSMutableDictionary *caseInfoToPass;
    NSMutableDictionary *myDict;
    NSArray * caseTitleArray;
    UIColor * lightCyanColor;
    UIColor * clearColor;
    NSInteger selectedRow;
   
}
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caseTypeViewHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addCommentTextViewHeightConst;

@end

@implementation AddCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
     self.navigationController.navigationBar.hidden = YES;
     caseTitleArray = [[NSArray alloc] initWithObjects:@"Criminal",@"Civil",@"others", nil];
    
    lightCyanColor = [UIColor colorWithRed:69/255.0 green:174/255.0 blue:202/255.0 alpha:1];
    clearColor =  [UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1];
   
    // Drop Down Button
    _caseTypeTextField.rightViewMode = UITextFieldViewModeAlways;
    UIButton *dropdownButtonAction =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    [dropdownButtonAction addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [dropdownButtonAction setImage:[UIImage imageNamed:@"dropDown"] forState:UIControlStateNormal];
    _caseTypeTextField.rightView = dropdownButtonAction;
   
    // Picker View
    UIPickerView *myPicker = [[UIPickerView alloc]init];
    myPicker.dataSource = self;
    myPicker.delegate = self;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarTintColor:[UIColor grayColor]];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barButtonDone =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeDateFromLabel:)];
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, barButtonDone, nil];
    [toolBar setItems:itemsArray];
    barButtonDone.tintColor=[UIColor blackColor];
    
     _caseTypeTextField.inputView = myPicker;
     _caseTypeTextField.inputAccessoryView = toolBar;
    
  
    //  default date
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [_startDateTextField setPlaceholder:[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]]];
    [_previousDateTextField setPlaceholder:[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]]];
    [_nextDateTextField setPlaceholder:[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]]];
    
    // text field Delegate
    
     _oppositeCounselContectTextField.delegate =self;
     _oppositeCounselNameTextField.delegate =self;
     _caseReatainedContectTextField.delegate =self;
     _caseRetainedNameTextField.delegate =self;
     _nextDateTextField.delegate =self;
     _caseStatusTextField.delegate =self;
     _caseNumberTextField.delegate =self;
     _judgeNameTextField.delegate =self;
     _caseTypeTextField.delegate =self;
     _previousDateTextField.delegate =self;
     _startDateTextField.delegate =self;
     _caseTitleTextField.delegate =self;
     _caseAmountTextField.delegate = self;
     _popUpCaseTypeTextField.delegate = self;
    _addCommentTextView.delegate = self;
    

    
     caseInfoToPass =[[NSMutableDictionary alloc]init];
     myDict =[[NSMutableDictionary alloc]init];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
   
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
   
    // Date Picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    _startDateTextField.inputView = datePicker;
    _previousDateTextField.inputView = datePicker;
    _nextDateTextField.inputView = datePicker;

    
    UIToolbar *toolBar1= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar1 setBarStyle:UIBarStyleDefault];
    [toolBar1 setBarTintColor:[UIColor grayColor]];

    UIBarButtonItem *flexButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(updateText:)];
    NSArray *itemsArray1 = [NSArray arrayWithObjects:flexButton1, doneButton, nil];
    
    [toolBar1 setItems:itemsArray1];
    doneButton.tintColor=[UIColor blackColor];
    
    _startDateTextField.inputAccessoryView = toolBar1;
    _previousDateTextField.inputAccessoryView = toolBar1;
    _nextDateTextField.inputAccessoryView = toolBar1;
    _caseTypeViewHeightConst.constant = 0;
    [self.view layoutIfNeeded];

}
-(void)viewWillAppear:(BOOL)animated{
     _caseTypeViewHeightConst.constant = 0;
    [_contentView layoutIfNeeded];
    CGRect frame = _hideAndShowView.frame;
    frame.size.height = 0;
    _hideAndShowView.frame = frame;

}
-(void)btnClicked:(id)seder
{


}
-(void)dismissKeyboard {
    
    [self.view endEditing:true];
}
# pragma Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

     return caseTitleArray.count;
}
-(NSString *)pickerView:(UIPickerView *)tagPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [caseTitleArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedRow = row;
    

}
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//    textView.frame = newFrame;
    _addCommentTextViewHeightConst.constant = newSize.height;
    [self.view layoutIfNeeded];
}

-(void)changeDateFromLabel:(id)sender
{
   _caseTypeTextField.text= caseTitleArray[selectedRow];
    if(selectedRow ==2){
        _caseTypeTextField.text= @"";
        _caseTypeViewHeightConst.constant = 46;
        [_contentView layoutIfNeeded];
        CGRect frame = _hideAndShowView.frame;
        frame.size.height = 46;
        _hideAndShowView.frame = frame;
    }
    [[self view] endEditing:YES];
}
# pragma keyboard handling
- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    if([_previousDateTextField isFirstResponder]){
        [_startDateView setBackgroundColor:clearColor];
        [_previousDateView setBackgroundColor:lightCyanColor];
    }
    else if([_caseTitleTextField isFirstResponder]){
        [_previousDateView setBackgroundColor:clearColor];
        [_caseTitleView setBackgroundColor:lightCyanColor];
    }
    else if([_caseAmountTextField isFirstResponder]){
        [_caseTitleView setBackgroundColor:clearColor];
         [_popUpCaseTypeView setBackgroundColor:clearColor];
        [_amountView setBackgroundColor:lightCyanColor];
    }
    else if([_judgeNameTextField isFirstResponder]){
        [_amountView setBackgroundColor:clearColor];
        [_judgeNameView setBackgroundColor:lightCyanColor];
    }
    else if([_caseNumberTextField isFirstResponder]){
        [_judgeNameView setBackgroundColor:clearColor];
        [_caseNumberView setBackgroundColor:lightCyanColor];
    }
    else if([_caseStatusTextField isFirstResponder]){
        [_caseNumberView setBackgroundColor:clearColor];
        [_caseStatusView setBackgroundColor:lightCyanColor];
    }
    else if([_nextDateTextField isFirstResponder]){
        [_caseStatusView setBackgroundColor:clearColor];
        [_nextDateView setBackgroundColor:lightCyanColor];
    }
    else if([_caseRetainedNameTextField isFirstResponder]){
        [_nextDateView setBackgroundColor:clearColor];
        [_retainedView setBackgroundColor:lightCyanColor];
    }
    else if([_caseReatainedContectTextField isFirstResponder]){
        [_retainedView setBackgroundColor:clearColor];
        [_mobileNumberView setBackgroundColor:lightCyanColor];
    }
    else if([_oppositeCounselNameTextField isFirstResponder]){
        [_mobileNumberView setBackgroundColor:clearColor];
        [_oppositeCounselView setBackgroundColor:lightCyanColor];
    }
    else if([_oppositeCounselContectTextField isFirstResponder]){
        [_oppositeCounselView setBackgroundColor:clearColor];
        [_oppositeCounselMobileNumberView setBackgroundColor:lightCyanColor];
    }
    else if([_addCommentTextView isFirstResponder]){
        [_oppositeCounselMobileNumberView setBackgroundColor:clearColor];
        [_commentView setBackgroundColor:lightCyanColor];
        }
    else if([_popUpCaseTypeTextField isFirstResponder]){
        [_caseTitleView setBackgroundColor:clearColor];
        [_popUpCaseTypeView setBackgroundColor:lightCyanColor];
    }
    else {
        [_commentView setBackgroundColor:clearColor];
        }
        _activeField = sender;
}
- (void)textFieldDidEndEditing:(UITextField *)sender
{
    
    _activeField = nil;
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+10.0, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
        [_scrollView scrollRectToVisible:_activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}
# pragma Date Picker
-(void)updateText:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.activeField.inputView;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    if([_startDateTextField isFirstResponder]) {
        _startDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:picker.date]];
        [_startDateTextField resignFirstResponder];
    }
    else if([_previousDateTextField isFirstResponder]){
        _previousDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:picker.date]];
        [_previousDateTextField resignFirstResponder];
    }
    else if([_nextDateTextField isFirstResponder]){
        _nextDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:picker.date]];
        [_nextDateTextField resignFirstResponder];
    }
    
}

# pragma Textfield Delegate METHODS
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [_previousDateTextField becomeFirstResponder];
    }
    else if (textField.tag == 2) {
        [_caseTitleTextField becomeFirstResponder];
    }
    else if (textField.tag == 3) {
        [_caseTypeTextField becomeFirstResponder];
    }
    else if (textField.tag == 4) {
        [_caseAmountTextField becomeFirstResponder];
    }
    else if (textField.tag == 15) {
        [_caseAmountTextField becomeFirstResponder];
    }
    else if (textField.tag == 5) {
        [_judgeNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 6) {
        [_caseNumberTextField becomeFirstResponder];
    }
    else if (textField.tag == 7) {
        [_caseStatusTextField becomeFirstResponder];
    }
    else if (textField.tag == 8) {
        [_nextDateTextField becomeFirstResponder];
    }
    else if (textField.tag == 9) {
        [_caseRetainedNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 10) {
        [_caseReatainedContectTextField becomeFirstResponder];
    }
    else if (textField.tag == 11) {
        [_oppositeCounselNameTextField becomeFirstResponder];
    }
    else if (textField.tag == 12) {
        [_oppositeCounselContectTextField becomeFirstResponder];
    }
    else if (textField.tag == 13) {
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        [self.scrollView setContentOffset:bottomOffset animated:YES];
        [_addCommentTextView becomeFirstResponder];
    }
    else if (_addCommentTextView.tag == 14) {
        [_addCommentTextView resignFirstResponder];
    }
    
   return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag == 11){
        if (_caseReatainedContectTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
    if(textField.tag == 11){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    if(textField.tag == 13){
        if (_oppositeCounselContectTextField.text.length >= 10 && range.length == 0)
            return NO;
    }
    if(textField.tag == 13){
        NSCharacterSet *chrectersString = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:chrectersString] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCaseButtonAction:(id)sender {
   
    
    myDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"logged_user_id"] ,@"user_id",[[NSUserDefaults standardUserDefaults]stringForKey:@"logged_user_security_hash"],@"user_security_hash",_startDateTextField.text ,@"case_start_date",_previousDateTextField.text,@"case_previous_date",_caseTitleTextField.text ,@"case_title",_caseTypeTextField.text,@"case_type",_judgeNameTextField.text,@"case_court_name",_caseNumberTextField.text,@"case_number",_caseStatusTextField.text,@"case_position_status",_nextDateTextField.text,@"case_next_date",_caseRetainedNameTextField.text,@"case_retained_name",_caseReatainedContectTextField.text,@"case_retained_contact",_oppositeCounselNameTextField.text,@"case_opposite_counselor_name",_oppositeCounselContectTextField.text,@"case_opposite_counselor_contact",_addCommentTextView.text,@"case_detail_comment", nil];
    NSLog(@"%@",_startDateTextField.text);
     
       [RequestManager getFromServer:@"add_case" parameters:myDict completionHandler:^(NSDictionary *responseDict) {
        
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
             //[self showBasicAlert:[responseDict objectForKey:@"message"] Message:@""];
                  NSLog(@" add case status %@", responseDict);
                
                [caseInfoToPass addEntriesFromDictionary:myDict];
              [self performSegueWithIdentifier:@"Home Screen" sender:self];
                
            }
        }
    }]; //add case api ends
}

//convert date to string
-(NSString*)getStringFromDate:(NSDate*)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"dd"];
    NSString *dateString = [df stringFromDate:date];
    [df setDateFormat:@"MM"];
    NSString  *myMonthString = [df stringFromDate:date];
    [df setDateFormat:@"YYYY"];
    NSString  *myYearString = [df stringFromDate:date];
    return [NSString stringWithFormat:@"%@-%@-%@",myYearString,myMonthString,dateString];
    
}

#pragma segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"confirm screen"]) {
        //pass info to next screen
        HomeViewController *vc = (HomeViewController *)segue.destinationViewController;
        vc.caseInfoToRecive =caseInfoToPass;
    }
}
# pragma alert Methods
-(void)showBasicAlert:(NSString*)title Message:(NSString *)message{
    title = [title stringByReplacingOccurrencesOfString:@"|" withString:@""];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
