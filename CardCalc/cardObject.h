//
//  cardObject.h
//  CardCalc
//
//  Created by Zee on 2013-02-26.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cardObject : NSObject

@property NSInteger numOfPlayers;
@property NSMutableArray* playerScores;
@property NSMutableArray* playerPayouts;
@property NSInteger betAmount;

- (void) emptyPlayerScores;
- (void) calculatePayout;

+ (cardObject *) instance;

@end
