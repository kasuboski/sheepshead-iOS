//
//  Deck.m
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/25/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import "Deck.h"

@implementation Deck
@synthesize cards;
- (id)init
{
    self = [super init];
    if (self) {
        cards = [[NSMutableArray alloc] init];
        //pts rank suit name
        //suit 0:clubs,1:spades,2:hearts,3:diamonds
        [cards addObject: [[Card alloc] init:0:0:0:@"7"]];
        [cards addObject: [[Card alloc] init:0:0:1:@"7"]];
        [cards addObject: [[Card alloc] init:0:0:2:@"7"]];
        [cards addObject: [[Card alloc] init:0:1:0:@"8"]];
        [cards addObject: [[Card alloc] init:0:1:1:@"8"]];
        [cards addObject: [[Card alloc] init:0:1:2:@"8"]];
        [cards addObject: [[Card alloc] init:0:2:0:@"9"]];
        [cards addObject: [[Card alloc] init:0:2:1:@"9"]];
        [cards addObject: [[Card alloc] init:0:2:2:@"9"]];
        [cards addObject: [[Card alloc] init:4:3:0:@"K"]];
        [cards addObject: [[Card alloc] init:4:3:1:@"K"]];
        [cards addObject: [[Card alloc] init:4:3:2:@"K"]];
        [cards addObject: [[Card alloc] init:10:4:0:@"10"]];
        [cards addObject: [[Card alloc] init:10:4:1:@"10"]];
        [cards addObject: [[Card alloc] init:10:4:2:@"10"]];
        [cards addObject: [[Card alloc] init:11:5:0:@"A"]];
        [cards addObject: [[Card alloc] init:11:5:1:@"A"]];
        [cards addObject: [[Card alloc] init:11:5:2:@"A"]];
        //trump
        [cards addObject: [[Card alloc] init:0:6:3:@"7"]];
        [cards addObject: [[Card alloc] init:0:7:3:@"8"]];
        [cards addObject: [[Card alloc] init:0:8:3:@"9"]];
        [cards addObject: [[Card alloc] init:4:9:3:@"K"]];
        [cards addObject: [[Card alloc] init:10:10:3:@"10"]];
        [cards addObject: [[Card alloc] init:11:11:3:@"A"]];
        [cards addObject: [[Card alloc] init:2:12:3:@"J"]];
        [cards addObject: [[Card alloc] init:2:13:2:@"J"]];
        [cards addObject: [[Card alloc] init:2:14:1:@"J"]];
        [cards addObject: [[Card alloc] init:2:15:0:@"J"]];
        [cards addObject: [[Card alloc] init:3:16:3:@"Q"]];
        [cards addObject: [[Card alloc] init:3:17:2:@"Q"]];
        [cards addObject: [[Card alloc] init:3:18:1:@"Q"]];
        [cards addObject: [[Card alloc] init:3:19:0:@"Q"]];
    }
    return self;
}
-(void) deal:(NSMutableArray*) blind : (NSMutableArray*) players {
    for(short x=0;x<10;x++){
        for(Player* player in players){
            [player.hand addObject: [self drawCard]];
        }
    }
    for(short y=0;y<2;y++){
        [blind addObject:[self drawCard]];
    }
}

-(void) shuffle {
    srand((int)time(nil));
    for(short x=0;x<50;x++){
        int index = rand()%[cards count];
        Card* C=[cards objectAtIndex:index];
        [cards removeObjectAtIndex: index];
        [cards addObject:C];
    }
}

-(id) drawCard {
    Card* newCard = [cards lastObject];
    [cards removeLastObject];
    
    return newCard;
}
-(void) showDeck {
    int count = 0;
    for (Card* card in cards){
        NSLog(@"Name %@ Suit %@ Rank %i Points %i",[[cards objectAtIndex:count] name],[[cards objectAtIndex:count] showSuit],[[cards objectAtIndex:count] rank], [[cards objectAtIndex:count] points] );
        count++;
    }
}

@end
