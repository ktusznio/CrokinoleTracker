//
//  PlayerSelectionViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSelectionViewController : UIViewController <UITextFieldDelegate> {
    UIButton *button;
}

@property (weak, nonatomic) IBOutlet UITextField *createPlayerTextField;

- (id)initWithButton:(UIButton *)aButton;
- (IBAction)editingNewPlayerDidEnd:(id)sender;

@end
