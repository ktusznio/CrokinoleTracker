//
//  MainMenuViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playGameButton;

- (IBAction)onPlayGameButtonTap:(id)sender;

@end
