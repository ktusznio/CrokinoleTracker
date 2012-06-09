//
//  PlayerActivationButton.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-09.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerActivationButtonDelegate

- (void)buttonWasPressed:(id)sender;

@end

@interface PlayerActivationButton : UIButton

@property (weak, nonatomic) id<PlayerActivationButtonDelegate> delegate;

@property (nonatomic) BOOL isActivated;
@property (weak, nonatomic) UIColor *color;

- (id)initWithFrame:(CGRect)frame
           delegate:(id<PlayerActivationButtonDelegate>)aDelegate
 initiallyActivated:(BOOL)anIsActivated
              color:(UIColor *)aColor;
- (void)onButtonTap;

@end
