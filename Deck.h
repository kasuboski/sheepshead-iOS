//
//  Deck.h
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/25/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Player.h"

@interface Deck : NSObject

@property (strong) NSMutableArray *cards;

-(id) init;
-(void) shuffle;
-(id) drawCard;
-(void) showDeck;
-(void) deal:(NSMutableArray*) blind : (NSMutableArray*) players;
@end
