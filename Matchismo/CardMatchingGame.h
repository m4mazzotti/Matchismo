//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 26/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

#define FIRST_CARD @"First Card"
#define SECOND_CARD @"Second Card"
#define THIRD_CARD @"Third Card"
#define SCORE @"Score"
#define MISMATCH @"Mismatch"
#define NEW_GAME @"New Game"

@interface CardMatchingGame : NSObject
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSInteger score;
@property (nonatomic) NSMutableArray *gameHistory;
@property (nonatomic) NSMutableArray *cards;

@end
