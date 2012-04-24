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

- (id)initForPlayer:(Player *)aPlayer;

@end
