//
//  PlayerStatisticsViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface PlayerStatisticsViewController : UIViewController {
    Player *player;
}

@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPerGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPerRoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *twentiesPerGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twentiesPerRoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundsPerGameLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewGamesButton;

- (id)initForPlayer:(Player *)aPlayer;

@end
