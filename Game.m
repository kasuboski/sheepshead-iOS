//
//  Game.m
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 7/4/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize lastWin;

Deck* deck;
NSMutableArray* players;
NSMutableArray* blind;
NSMutableArray* currentPlay;

- (id)init:(NSString*) name
{
    self = [super init];
    if (self) {
        lastWin = 0;
        players = [[NSMutableArray alloc] init];
        players[0] = [[Player alloc] init: name : 0];
        players[1] = [[Player alloc] init: @"Bob" : 1];
        players[2] = [[Player alloc] init: @"John" : 2];
        deck = [[Deck alloc] init];
        blind = [[NSMutableArray alloc]init];
        currentPlay = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startSinglePlayerGame
{
    [self reset];
    [self playHand];
    
	[self beginGame];
}
- (Player *)playerAtPosition:(PlayerPosition)position
{
        
}
-(void) deterWin {
    int hRank = 0; //highest rank in trick
    int curSuit = -1; //-1 = trump
    if([[currentPlay objectAtIndex:0] rank] < 6){
        curSuit = [[currentPlay objectAtIndex:0] suit];
    }
    for(Card* card in currentPlay){
        if(card.rank > hRank && (((card.suit == curSuit) || curSuit == -1) || card.rank >= 6)){
            hRank = card.rank;
            lastWin = card.owner;
        }
    }
    NSLog(@"The current winner is %@\n", players[lastWin]);
}
-(void) resetPlayers {
    for(Player* p in players){
        p.points = [p curTotal];
        p.curTotal = 0;
    }
}
-(void) reset {
    [self resetPlayers];
    [deck shuffle];
    [deck deal:blind:players];
    lastWin = 0; //winner of last trick defaults at 0 = player; 1=cplayer1, 2= cplayer2
    
    [players[0] sortHand];
    [players[0] showHand];
    
    int pickDes = 0;
    NSLog(@"Do you want to pick?(1/0)");
    scanf("%d", &pickDes);
    NSLog(@"%d",pickDes);
    //if player wants to pick he picks and buries cards
    if(pickDes == 1){
        [players[0] pick: blind];
        [players[0] sortHand];
        [players[0] showHand];
        //pick cards to bury
        int loc = 0;
        NSLog(@"Choose a card to bury");
        scanf("%d", &loc);
        ((Player*)players[0]).curTotal += [[((Player*)players[0]).hand objectAtIndex:loc] points];
        [((Player*)players[0]).hand removeObjectAtIndex:loc];
        [players[0] sortHand];
        [players[0] showHand];
        NSLog(@"Choose a card to bury");
        scanf("%d", &loc);
        ((Player*) players[0]).curTotal += [[((Player*)players[0]).hand objectAtIndex:loc] points];
        [((Player*)players[0]).hand removeObjectAtIndex:loc];
    }
    else{
        //one of computers pick
        int numTrumpReq = arc4random() % 4 + 2;
        int numTrump = 0; //count of trump currently
        for(Card* card in ((Player*)players[1]).hand){
            if(card.rank > 5){
                numTrump++;
            }
        }
        if(numTrump >= numTrumpReq){
            [players[1] pick:blind];
            [players[1] bury];
            NSLog(@"%@ picked", [players[1] name]);
        }
        else {
            [players[2] pick:blind];
            [players[2] bury];
            NSLog(@"%@ picked", [players[2] name]);
        }
    }
}
-(void) playHand{
    for(int numCards=10; numCards>0;numCards--){
        [currentPlay removeAllObjects];
        switch (lastWin) {
            case 0:
                [players[0] playTurn:currentPlay];
                [self deterWin];
                [players[1] playCTurn:currentPlay:players];
                [self deterWin];
                [players[2] playCTurn:currentPlay:players];
                [self deterWin];
                break;
            case 1:
                [players[1] playCTurn:currentPlay:players];
                [self deterWin];
                [players[2] playCTurn:currentPlay:players];
                [self deterWin];
                [players[0] playTurn:currentPlay];
                [self deterWin];
                break;
            case 2:
                [players[2] playCTurn:currentPlay:players];
                [self deterWin];
                [players[0] playTurn:currentPlay];
                [self deterWin];
                [players[1] playCTurn:currentPlay:players];
                [self deterWin];
                break;
            default:
                break;
        }
        //find points in trick
        int trickTotal = 0;
        for (Card* card in currentPlay){
            trickTotal += [card points];
        }
        ((Player*)[players objectAtIndex:lastWin]).curTotal += trickTotal;
        NSLog(@"%@ won", players[lastWin]);
        
    }
    //determine hand winner
    for(Player* p in players){
        if([p picker]){
            if([p curTotal]>60){
                NSLog(@"%@, the picker won",[p name]);
            }
            else {
                NSLog(@"The partners won");
            }
            break;
        }
    }
}

- (void)quitGameWithReason:(QuitReason)reason
{
    //cancel scheduled tasks
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//	_state = GameStateQuitting;
    
//	if (reason == QuitReasonUserQuit && ![self isSinglePlayerGame])
//	{
//		if (self.isServer)
//		{
//			Packet *packet = [Packet packetWithType:PacketTypeServerQuit];
//			[self sendPacketToAllClients:packet];
//		}
//		else
//		{
//			Packet *packet = [Packet packetWithType:PacketTypeClientQuit];
//			[self sendPacketToServer:packet];
//		}
//	}
    
//	[_session disconnectFromAllPeers];
//	_session.delegate = nil;
//	_session = nil;
    
	[self.delegate game:self didQuitWithReason:reason];
}
@end
