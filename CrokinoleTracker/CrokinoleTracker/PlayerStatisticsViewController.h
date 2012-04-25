//
//  PlayerStatisticsViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStatisticsViewController : UIViewController {
    Player *player;
}

@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPerGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPerRoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *twentiesPerGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twentiesPerRoundLabel;

- (id)initForPlayer:(Player *)aPlayer;

@end
