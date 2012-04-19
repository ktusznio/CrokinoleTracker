//
//  ScorekeepingViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScorekeepingViewController : UIViewController {
    Game *game;
}

@property (weak, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundNumberLabel;

- (id)initForGame:(Game *)aGame;

@end
