//
//  Card.h
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/25/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property int owner;
@property int points;
@property int rank;
@property int suit;
@property (strong) NSString* name;
-(id) init:(int) pts :(int) rk :(int) su :(NSString*)na;
-(NSString*) showSuit;

@end
