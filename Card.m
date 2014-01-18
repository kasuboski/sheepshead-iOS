//
//  Card.m
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/25/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize points,rank, name,suit,owner;
- (id)init:(int)pts :(int)rk :(int)su :(NSString*)na
{
    self = [super init];
    if (self) {
        points = pts;
        rank = rk;
        suit = su;
        name = na;
        owner = 10;
    }
    return self;
}
-(NSString*) showSuit {
    switch (suit) {
        case 0:
            return @"Clubs";
            break;
        case 1:
            return @"Spades";
            break;
        case 2:
            return @"Hearts";
            break;
        case 3:
            return @"Diamonds";
            break;
        default:
            return @"Well poop.";
            break;
    }
}
@end
