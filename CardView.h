//
//  CardView.h
//  Snap
//
//  Created by Josh Kasuboski on 12/8/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

const CGFloat CardWidth;
const CGFloat CardHeight;

@class Card;
@class Player;

@interface CardView : UIView

@property (nonatomic, strong) Card *card;

- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay;
- (void)animateTurningOverForPlayer:(Player *)player;
- (void)animateRecycleForPlayer:(Player *)player withDelay:(NSTimeInterval)delay;
- (void)unloadFront;
- (void)unloadBack;
- (void)loadFront;
- (void)animateCloseAndMoveFromPlayer:(Player *)fromPlayer toPlayer:(Player *)toPlayer withDelay:(NSTimeInterval)delay;
- (void)animatePayCardFromPlayer:(Player *)fromPlayer toPlayer:(Player *)toPlayer;
- (void)animateRemovalAtRoundEndForPlayer:(Player *)player withDelay:(NSTimeInterval)delay;

@end