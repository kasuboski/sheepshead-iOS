//
//  main.m
//  Sheepshead Obj-c
//
//  Created by Josh Kasuboski on 1/25/13.
//  Copyright (c) 2013 Josh Kasuboski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Table.h"
#import <stdlib.h>


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSLog(@"Let's play Sheepshead\n");
        
        char str[10] = {0};
        NSLog(@"What is your name");
        scanf("%s",str);
        NSString *name = [NSString stringWithUTF8String:str];

        Table *t = [[Table alloc] init: name];
        
        BOOL again = YES; //in a hand which consists of 10 tricks
        do{
            [t reset];
            [t playHand];
            NSLog(@"Would you like to play again?");
            scanf("%s",str);
            NSString *choice = [NSString stringWithUTF8String:str];
            if([choice isEqual: @"Y"] || [choice isEqual: @"y"]){
                again = YES;
            }
            else{
                again = NO;
            }
        }while (again);
        
        //[player playCard:currentPlay : 0];
    }
    return 0;
}

