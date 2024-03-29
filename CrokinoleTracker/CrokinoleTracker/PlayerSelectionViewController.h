//
//  PlayerSelectionViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UIButton *button;
}

@property (weak, nonatomic) IBOutlet UITextField *createPlayerTextField;
@property (weak, nonatomic) IBOutlet UITableView *existingPlayersTableView;

- (id)initWithButton:(UIButton *)aButton;
- (IBAction)editingNewPlayerDidEnd:(id)sender;

@end
