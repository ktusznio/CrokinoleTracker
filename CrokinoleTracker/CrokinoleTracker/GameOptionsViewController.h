//
//  GameOptionsViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOptionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *choosePlayerOneButton;
@property (weak, nonatomic) IBOutlet UIButton *choosePlayerTwoButton;

- (IBAction)onSelectPlayerButtonTap:(id)sender;

@end
