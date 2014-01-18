//
//  Player.m
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/26/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize name, points,hand,curTotal,picker,ID;
- (id)init:(NSString*)na :(int)I
{
    self = [super init];
    if (self) {
        hand = [[NSMutableArray alloc] init];
        name = na;
        points = 0;
        curTotal = 0;
        picker = NO;
        ID = I;
        //playerType = player;
    }
    return self;
}
-(void) showHand {
    int count = 0;
    NSLog(@"Your Hand");
    for (Card* card in hand){
        NSLog(@"%d: %@ of %@",count,[[hand objectAtIndex:count] name],[[hand objectAtIndex:count] showSuit]);
        count++;
    }
}
-(void) sortHand {
    NSArray *sortedArray;
    sortedArray = [hand sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        int *first = [(Card*)a rank];
        int *second = [(Card*)b rank];
        if(first > second){
            return NSOrderedDescending;
        }
        else if(first < second){
            return NSOrderedAscending;
        }
        else {
            return NSOrderedSame;
        }
    }];
    [hand removeAllObjects];
    [hand addObjectsFromArray:sortedArray];
}
-(void) playCard: (NSMutableArray*) trick : (int) index {
    int curSuit = -1;//if trump suit = -1
    //if not trump
    if( trick.count != 0 && [[trick objectAtIndex:0] rank] < 6){
        curSuit = [[trick objectAtIndex:0] suit];
    }
    //if card to play is the same suit and not trump or
    //if trump was led and the card to play is trump
    if(([[self.hand objectAtIndex:index] suit] == curSuit && curSuit != -1 && trick.count !=0) || (curSuit == -1 && [[self.hand objectAtIndex:index] rank] >= 6 && trick.count != 0)){
//        [trick addObject:[self.hand objectAtIndex:index]];
//        ((Card*)[trick lastObject]).owner = [self ID];
//        [self.hand removeObjectAtIndex:index];
    }
    else{
        NSLog(@"You have to follow suit");
    }
    [trick addObject:[self.hand objectAtIndex:index]];
    ((Card*)[trick lastObject]).owner = [self ID];
    [self.hand removeObjectAtIndex:index];
    NSLog(@"%@ played the %@ of %@",[self name],[[trick lastObject] name], [[trick lastObject] showSuit]);
}
-(void) playTurn: (NSMutableArray*) trick {
    NSLog(@"Cards in Play");
    if ([trick count]) {
        for (Card* card in trick){
            NSLog(@"%@ of %@", [card name], [card showSuit]);
        }
    }
    else {
        NSLog(@"No cards have been played yet");
    }
    
    [self showHand];
    NSLog(@"What card would you like to play?");
    int cardIndex = 0;
    scanf("%d",&cardIndex);
    [self playCard:trick :cardIndex];
}
-(void) playCTurn: (NSMutableArray*) trick : (NSMutableArray*) players {
    [self sortHand];
    //determine who is winning currently
    int curWin = 0;
    int hRank = 0; //highest rank in trick
    for(Card* card in trick){
        if(card.rank > hRank){
            hRank = card.rank;
            curWin = card.owner;
        }
    }
    int highPt = 0;//location of highest point card
    int high = 0;//value of highest points

    for(int loc=0; loc< [hand count];loc++){
        if([[hand objectAtIndex:loc] points] > high){
            high = [[hand objectAtIndex:loc] points];
            highPt = loc;
        }
    }
    BOOL hasTrump = NO;
    int lowTrump = 0; //location of lowest trump card don't use without checking hasTrump
    for(Card* card in self.hand){
        if(card.rank > 5){
            hasTrump = YES;
            break;
        }
        lowTrump++;
    }
    
    BOOL isPicker = NO;
    if([self picker]){
        isPicker = YES;
    }
    if([trick count] == 0){ //no one played yet
        if(isPicker){
            [self playCard:trick : (int)[self.hand count]-1]; //play highest trump
        }
        else {
            int ace = 0;
            BOOL hasAce = NO;
            //if have ace play it
            for(Card* card in self.hand){
                if(([card.name isEqual: @"A"]) && (card.suit != 3)){
                    hasAce = YES;
                    break;
                }
                ace++;
            }
            if(hasAce){
                [self playCard: trick : ace];
            }
            else {
                [self playCard:trick : 0]; //play lowest ranked card
            }
        }
    }
    else if([[trick objectAtIndex:0] rank] > 5){ //if trump led
        if((!self.picker) && ([[players objectAtIndex:curWin] picker])){ // if picker winning and it's not you
            int count = 0;
            BOOL canBeat = NO;
            for(Card* card in self.hand){
                if(card.rank > hRank){
                    canBeat = YES;
                    break;
                }
                count++;
            }
            if(canBeat){
                [self playCard:trick :count];
            }
            else {
                if(hasTrump){
                    [self playCard:trick : lowTrump ]; //play lowest trump
                }
                else {
                    [self playCard:trick : 0]; // play lowest card
                }
            }
        }
        else if(![[players objectAtIndex:curWin] picker]){ //partners winning
            int count = 0;
            BOOL canBeat = NO;
            for(Card* card in self.hand){
                if(card.rank > hRank && card.rank > 5){
                    canBeat = YES;
                    break;
                }
                count++;
            }
            if(self.picker){
                if(canBeat){
                    //play lowest trump to win
                            [self playCard:trick : count];
                }
                else {
                    //if can't win play lowest trump or lowest card
                    if(hasTrump){
                        [self playCard:trick :lowTrump];
                    }
                    else {
                        [self playCard:trick :0];
                    }
                }
            }
            else {
                if(hasTrump){
                    [self playCard:trick : lowTrump]; //play lowest trump
                }
                else {
                    [self playCard:trick : highPt];
                }
            }
        }
    }
    else { //fail was led
        int curSuit = [[trick objectAtIndex:0] suit];
        BOOL canFollow = NO;
        for(Card* card in self.hand){
            if(card.suit == curSuit && card.rank < 6){
                canFollow = YES;
                break;
            }
        }
        BOOL canBeat = NO;
        int count = 0;
        for(Card* card in self.hand){
            if((card.suit == curSuit) && (card.rank > hRank)){
                canBeat = YES;
                break;
            }
            count++;
        }
        if(canFollow){
            if((!self.picker) && ([[players objectAtIndex:curWin] picker])){ //picker winning and not you
                
                if(canBeat && [[hand objectAtIndex:count] rank] < 6){
                    [self playCard:trick : count]; //play lowest correct card to beat picker
                }
                else { //play lowest card of same suit
                    int count = 0;
                    for(Card* card in self.hand){
                        if(card.suit == curSuit){
                            [self playCard:trick : count];
                            break;
                        }
                        count++;
                    }
                }
            }
            else {
                if(isPicker){
                    if(canBeat){
                        //play lowest card that can win if not trump
                        if([[[self hand] objectAtIndex:count] rank] < 6){
                            [self playCard:trick :count];
                        }
                    }
                    else {
                        [self playCard:trick : 0];
                    }
                }
                else {
                    [self playCard:trick : highPt]; //play highest pt card
                }
            }
        }
        else {
            if((!self.picker) && ([[players objectAtIndex:curWin] picker])){
                if(canBeat){
                    [self playCard:trick : count]; //play lowest card that wins
                }
                else {
                    [self playCard:trick : 0]; //play low card
                }
            }
            else {
                if(isPicker){
                    if(canBeat){
                        [self playCard:trick :count]; //play lowest card that wins
                    }
                }
                else {
                    [self playCard:trick : highPt];
                }
            }
        }
    }
}
//-(BOOL) hasTrump {
//    for(Card* card in self.hand){
//        if(card.rank >5){
//            return YES;
//        }
//    }
//    return NO;
//}
-(void) pick: (NSMutableArray*) blind {
    self.picker = YES;
    [self.hand addObjectsFromArray:blind];
    [blind removeAllObjects];
}
-(void) bury {
    [self sortHand];
    //just bury lowest cards
    curTotal += [[hand objectAtIndex:0] points];
    curTotal += [[hand objectAtIndex:1] points];
    [hand removeObjectAtIndex:0];
    [hand removeObjectAtIndex:0];
}
-(NSString*)description{
    return [NSString stringWithFormat:@"%@",self.name];
}

@end