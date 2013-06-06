//
//  cardObject.m
//  CardCalc
//
//  Created by Zee on 2013-02-26.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import "cardObject.h"

@implementation cardObject

@synthesize numOfPlayers = _numOfPlayer;
@synthesize playerScores = _playerScores;

static cardObject* instance;

+ (cardObject *) instance {
    if (!instance){
        instance = [[cardObject alloc] init];
    }
    return instance;
}

- (id) init {
    self = [super init];
    if (self){
        [self setNumOfPlayers:4];
        self.playerScores = [[NSMutableArray alloc] init];
        self.playerPayouts = [[NSMutableArray alloc] init];
        for (int i=0;i<5;i++){
            NSNumber* initValue = [NSNumber numberWithInt:0];
            [self.playerScores insertObject:initValue  atIndex:i];
            [self.playerPayouts insertObject:initValue atIndex:i];
        }
        [self setBetAmount:1];
    }
    return self;
}

- (void) emptyPlayerScores{
    for (int i=0;i<5;i++){
        NSNumber* emptyValue = [NSNumber numberWithInt:0];
        [self.playerScores replaceObjectAtIndex:i withObject:emptyValue];
        [self.playerPayouts replaceObjectAtIndex:i withObject:emptyValue];
    }
}

- (void) calculatePayout{
    for (int i=0;i<self.numOfPlayers;i++){
        int playerPayout = 0;
        for (int j=0;j<self.numOfPlayers;j++){
            if (i!=j){
                playerPayout += (((NSNumber*)[self.playerScores objectAtIndex:j]).integerValue - ((NSNumber*)[self.playerScores objectAtIndex:i]).integerValue)*self.betAmount;
            }
        }
        NSNumber *payoutNum = [NSNumber numberWithInt:playerPayout];
        [self.playerPayouts replaceObjectAtIndex:i withObject:payoutNum];
    }
}

@end
