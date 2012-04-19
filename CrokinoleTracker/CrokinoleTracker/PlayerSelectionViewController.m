//
//  PlayerSelectionViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "PlayerSelectionViewController.h"

@implementation PlayerSelectionViewController

@synthesize createPlayerTextField;

- (id)initWithButton:(UIButton *)aButton {
    self = [super init];

    if (self) {
        button = aButton;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setCreatePlayerTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Dismiss the keyboard when "return" is pressed.
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // Clear the placeholder text when editing begins.
    [textField setText:@""];
}

# pragma mark -

- (IBAction)editingNewPlayerDidEnd:(id)sender {
    // Update the game options screen's button title.
    NSString *newPlayerName = [createPlayerTextField text];
    [button setTitle:newPlayerName forState:UIControlStateNormal];

    // Dismiss this view.
    [self dismissModalViewControllerAnimated:YES];
}

@end
