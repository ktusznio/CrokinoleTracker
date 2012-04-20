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
    int playerOneStartingGameScore;
    int playerTwoStartingGameScore;
}

@property (weak, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *playerOne20sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOne15sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOne10sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOne5sLabel;
@property (weak, nonatomic) IBOutlet UIStepper *playerOne20sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerOne15sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerOne10sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerOne5sStepper;
@property (weak, nonatomic) IBOutlet UILabel *playerTwo20sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwo15sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwo10sLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwo5sLabel;
@property (weak, nonatomic) IBOutlet UIStepper *playerTwo20sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerTwo15sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerTwo10sStepper;
@property (weak, nonatomic) IBOutlet UIStepper *playerTwo5sStepper;


- (id)initForGame:(Game *)aGame;
- (IBAction)valueChanged:(id)sender;
- (UILabel *)labelForStepper:(UIStepper *)stepper;
- (IBAction)onQuitGameButtonTap:(id)sender;
- (IBAction)onNextRoundButtonTap:(id)sender;

@end
