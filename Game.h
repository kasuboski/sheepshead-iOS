//
//  Game.h
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 7/4/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@class Game;

@protocol GameDelegate <NSObject>

- (void)game:(Game *)game didQuitWithReason:(QuitReason)reason;
- (void)gameDidBegin:(Game *)game;
//- (void)gameWaitingForServerReady:(Game *)game;
//- (void)gameWaitingForClientsReady:(Game *)game;
- (void)game:(Game *)game playerDidDisconnect:(Player *)disconnectedPlayer redistributedCards:(NSDictionary *)redistributedCards;
- (void)gameShouldDealCards:(Game *)game startingWithPlayer:(Player *)startingPlayer;
- (void)game:(Game *)game didActivatePlayer:(Player *)player;
- (void)game:(Game *)game player:(Player *)player turnedOverCard:(Card *)card;
- (void)game:(Game *)game didRecycleCards:(NSArray *)recycledCards forPlayer:(Player *)player;
- (void)game:(Game *)game player:(Player *)fromPlayer paysCard:(Card *)card toPlayer:(Player *)toPlayer;
- (void)game:(Game *)game roundDidEndWithWinner:(Player *)player;
- (void)gameDidBeginNewRound:(Game *)game;

@end

@interface Game : NSObject

@property (nonatomic, weak) id <GameDelegate> delegate;
@property NSMutableArray* players;
@property NSMutableArray* blind;
@property NSMutableArray* currentPlay;//collection of cards currently in play
@property Deck* deck;
@property int lastWin;

-(id)init:(NSString*) name;
-(void) deterWin;
-(void) resetPlayers;
-(void) reset;
-(void) playHand;

- (void)quitGameWithReason:(QuitReason)reason;
- (Player *)playerAtPosition:(PlayerPosition)position;
- (void)startSinglePlayerGame;
@end
