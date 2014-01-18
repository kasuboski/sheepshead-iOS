//
//  Table.h
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 7/4/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Table : NSObject
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
@end
