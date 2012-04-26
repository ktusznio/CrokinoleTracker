//
//  PlayerGameListViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-26.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerGameListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    Player *player;
}

@property (weak, nonatomic) IBOutlet UITableView *gameTableView;

- (id)initForPlayer:(Player *)aPlayer;

@end
