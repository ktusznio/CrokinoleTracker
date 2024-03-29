//
//  MainMenuViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playGameButton;
@property (weak, nonatomic) IBOutlet UIButton *viewStatisticsButton;

- (IBAction)onPlayGameButtonTap:(id)sender;
- (IBAction)onViewStatisticsButtonTap:(id)sender;

@end
