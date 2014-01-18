//
//  Player.h
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/26/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

typedef enum
{
	PlayerPositionBottom,  // the user
	PlayerPositionLeft,
	PlayerPositionTop,
	PlayerPositionRight
}
PlayerPosition;

@interface Player : NSObject

@property (nonatomic, assign) PlayerPosition position;
@property (strong) NSMutableArray *hand;
@property NSString* name;
@property int points; //chip value
@property int curTotal; //points from tricks
@property BOOL picker; //if is picker
@property int ID;
@property (nonatomic, assign) int gamesWon;

-(id) init: (NSString*) name :(int)ID;
-(void) showHand;
-(void) sortHand;
-(void) playCard: (NSMutableArray*) trick : (int) index;
-(void) playTurn: (NSMutableArray*) trick;
-(void) playCTurn: (NSMutableArray*) trick : (NSMutableArray*) players;
//-(BOOL) hasTrump;
-(void) pick: (NSMutableArray*) blind;
-(void) bury;
@end
