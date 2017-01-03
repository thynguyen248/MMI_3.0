//
//  FromAddressViewController.m
//  MeeMeepMobile
//
//  Created by John Rowland on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "FromAddressViewController.h"

@implementation FromAddressViewController

@synthesize inptSuburb, inptStreetNumber, inptStreetName, inptState, inptPostCode, statePicker;


@synthesize viewToScroll;

@synthesize lblPostCodeNote,lblStreetNameNote,lblStateNote,lblStreetNumberNote,lblSuburbNote;

@synthesize tableViewDDState;

@synthesize navBar;

@synthesize navBarTitleItem;

@synthesize btnDone;


@synthesize keyboardToolbar;




@synthesize searchBar, searchResultsTable;


-(IBAction)btnSearchClick:(id)sender{
    NSArray* annotations = [annotationsClient findLocationOf:searchBar.text];
    annotations = mapAnnotations;
}




-(IBAction)backgroundTouched:(id)sender
{
    [self.keyboardToolbar resignKeyboard:nil];
}


-(BOOL) checkForFieldErrors{
    bool fieldError = false;
    
    //The input methods (keyboards, pickers .etc)ensure the data is of the correct format
    //therefore it is only necessary to check that a value has been entered
    
    //Validate street number
    if ([inptStreetNumber.text isEqualToString:@""]){
        lblStreetNumberNote.text = @"* Required Field";
        fieldError = true;
    } else lblStreetNumberNote.text = @"*";

    //Validate street name
    if ([inptStreetName.text isEqualToString:@""]){
        lblStreetNameNote.text = @"* Required Field";
        fieldError = true;
    } else lblStreetNameNote.text = @"*";
    

    //Validate suburb
    if ([inptSuburb.text isEqualToString:@""]){
        lblSuburbNote.text = @"* Required Field";
        fieldError = true;
    } else lblSuburbNote.text = @"*";
    
    //Validate state
    if ([inptState.text isEqualToString:@""]){
        lblStateNote.text = @"* Required Field";
        fieldError = true;
    } else lblStateNote.text = @"*";
    
    //Validate postcode
    
    if (
        ([inptPostCode.text isEqualToString:@""]==false)&&
        ([GUICommon isValidPostCode:inptPostCode.text forState:inptState.text]==false)
       )
    {
        lblPostCodeNote.text = @"* Invalid Post Code";
        fieldError = true;
    } else lblPostCodeNote.text = @"";
    
    
    return fieldError;
}

 



-(IBAction) btnBackClicked{
    [self dismissModalViewControllerAnimated:TRUE];
}





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}





- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [statesArray count];
}





- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [statesArray objectAtIndex:row];
}





- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    inptState.text = [statesArray objectAtIndex:row];
    [tableViewDDState reloadData];
}





-(id) initWithAddress: (MMJobAddress*) address{
    self = [super init];
    addressObject = address;
    return self;
}





-(IBAction) btnDoneClicked{
    //Try to populate address object with field data
    if ([self checkForFieldErrors]==false){
        //No Field errors found
        addressObject.suburb = inptSuburb.text;
        addressObject.streetNumber = inptStreetNumber.text;
        addressObject.streetName = inptStreetName.text;
        addressObject.state = inptState.text;
        
        if(inptPostCode.text.length>0){
            //Pass empty string as nil (significant to underlying API's)
            addressObject.postCode = inptPostCode.text;
        } else addressObject.postCode = nil;
        
        [self dismissModalViewControllerAnimated:TRUE];
    }
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}





#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Style done button
    self.btnDone.layer.backgroundColor = [[UIColor cyanColor] CGColor];
    self.btnDone.layer.cornerRadius = 8.0;
    [self.btnDone setUserInteractionEnabled:YES];
    self.btnDone.reversesTitleShadowWhenHighlighted = YES;   
    
    //Initialises keyboard toolbar (input accessory that provides Previous,Next,Done functionality)
    keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view :
                       [[NSArray alloc] initWithObjects:
                                                                          inptStreetNumber,
                                                                          inptStreetName,
                                                                          inptSuburb,
                                                                          inptState,
                                                                          inptPostCode,
                                                                          nil]];
    
    //State options
    statesArray = [[NSMutableArray alloc] init];
    [statesArray addObject:@"ACT"];
    [statesArray addObject:@"NSW"];
    [statesArray addObject:@"VIC"]; 
    [statesArray addObject:@"QLD"];
    [statesArray addObject:@"SA"];
    [statesArray addObject:@"WA"];  
    [statesArray addObject:@"TAS"];
    [statesArray addObject:@"NT"];   
    
    //Setup keyboard and input accessory (keyboardtoolbar) for various controls
    //
    inptState.inputView = statePicker;
    inptState.inputAccessoryView = keyboardToolbar;
    
    inptStreetNumber.text = [GUICommon formatForString:addressObject.streetNumber];
    inptStreetNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    inptStreetNumber.inputAccessoryView = keyboardToolbar;
    
    inptStreetName.text = [GUICommon formatForString:addressObject.streetName];
    inptStreetName.keyboardType = UIKeyboardTypeDefault;
    inptStreetName.inputAccessoryView = keyboardToolbar;
    
    inptSuburb.text = [GUICommon formatForString:addressObject.suburb];
    inptSuburb.keyboardType = UIKeyboardTypeDefault;
    inptSuburb.inputAccessoryView = keyboardToolbar;
    
    inptState.text = [GUICommon formatForString:addressObject.state];
    [tableViewDDState reloadData];
    
    
    inptPostCode.text = [GUICommon formatForString:addressObject.postCode];
    inptPostCode.keyboardType = UIKeyboardTypeNumberPad;
    inptPostCode.inputAccessoryView = keyboardToolbar;
    
    //Initialize scroll view
    //Add 'view to be scrolled' to scrollview
    //Add scroll view to main view
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 38, self.view.frame.size.width, self.view.frame.size.height)]; 
    [scroller addSubview:viewToScroll]; 
    scroller.contentSize = CGSizeMake(viewToScroll.frame.size.width, viewToScroll.frame.size.height); 
    [self.view addSubview:scroller];  
    
    //Record original height of view for resizing later (keyboard related)
    originalViewFrame = CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, scroller.frame.size.width, scroller.frame.size.height);
    
    [self registerForKeyboardNotifications];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}







#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 31;     
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==searchResultsTable) return [mapAnnotations count];
    else
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==searchResultsTable){
        UITableViewCell* cell = [GUICommon getMyTableViewCell:tableView];
        cell.textLabel.text = [mapAnnotations objectAtIndex:indexPath.row];
        return cell;
    }
    else{
    
        UITableViewCell* cell;
    
        EditableTableViewCell* myCell = [GUICommon getEditableTableViewCell:tableView];
        [myCell.textField setUserInteractionEnabled:false];
    
        UIButton* accessory = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessory setImage:[UIImage imageNamed:@"DownArrow.png"] forState:UIControlStateNormal];
        accessory.frame = CGRectMake(0, 0, 26, 26);
        accessory.userInteractionEnabled = YES;
        [accessory setEnabled:false];
        myCell.accessoryView = accessory;
    
        myCell.textField.text = inptState.text;

        cell = myCell;
    
        return cell;
    }
    
}




#pragma mark - Table view delegate


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    [inptState becomeFirstResponder];
}



//


- (void) registerForKeyboardNotifications {
    DLog(@"Registering for keyboard notifications...");
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasShown:)  name:UIKeyboardDidShowNotification object:nil];
    
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    scroller.frame = CGRectMake(originalViewFrame.origin.x, originalViewFrame.origin.y , originalViewFrame.size.width, originalViewFrame.size.height- (kbSize.height + keyboardToolbar.frame.size.height));    
}


- (void) keyboardWasHidden:(NSNotification *) notification {
    DLog(@"Keyboard was hidden!");

    CGFloat yOffset = scroller.contentOffset.y;
    
    scroller.frame = CGRectMake(originalViewFrame.origin.x, originalViewFrame.origin.y , originalViewFrame.size.width, originalViewFrame.size.height);

    scroller.contentOffset = CGPointMake(0, yOffset);   //CODE IS BOGUS AND SHOULD NOT WORK (BUT IT DOES) - should have set to (0,0)

}


-(void) textFieldDidBeginEditing:(UITextField *)textField{
    //[scrollView setScrollEnabled:FALSE];
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    //[scrollView setScrollEnabled:TRUE];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    
    if ((textField==inptState)&([inptState.text isEqualToString:@""]))
        [self pickerView: statePicker didSelectRow:0 inComponent:0];   
    
    /*
    //if from or destination is selected then make those fields visible on screen (no keyboard)
    if (textField==inptState)
    {
        CGRect areaToView = CGRectMake(
                                       inptState.frame.origin.x,
                                       inptState.frame.origin.y-30,
                                       inptState.frame.size.width,
                                       (inptState.frame.origin.y-inptState.frame.origin.y+30)
                                       );
        [self.scrollView scrollRectToVisible:areaToView animated:FALSE];
    }
    */
    
    //Change size of scrollView (Put it above the keyboard)
    //scroller.frame = CGRectMake(originalViewFrame.origin.x, originalViewFrame.origin.y, scroller.frame.size.width, 155);

    
    return YES;
}




    






-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ((textField==inptPostCode)&(string.length>=1)){
        if (inptPostCode.text.length>=4) return false; else return true;
    } else return true;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{return true;}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    //Remove extra white spaces
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ((textField==inptStreetName)||(textField==inptSuburb)){
        //Make sure the first letter is capitalized
        textField.text = textField.text.capitalizedString;
    }
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{return true;}



@end
