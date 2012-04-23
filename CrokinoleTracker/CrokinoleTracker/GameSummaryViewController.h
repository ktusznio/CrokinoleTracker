//
//  GameSummaryViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 23-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"

@interface GameSummaryViewController : UIViewController {
    Game *game;
}

@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

- (id)initForGame:(Game *)aGame;
- (IBAction)onRematchButtonTap:(id)sender;

@end
