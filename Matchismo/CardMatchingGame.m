//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 26/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_SCORE 1

@interface CardMatchingGame ()
@end

@implementation CardMatchingGame

- (NSMutableArray *)gameHistory
{
    if (!_gameHistory) _gameHistory = [[NSMutableArray alloc] initWithObjects:@{NEW_GAME : @YES}, nil];
    
    return _gameHistory;
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    NSDictionary *flipResult = nil;
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        NSUInteger matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            flipResult = @{FIRST_CARD : card.contents, SECOND_CARD : otherCard.contents, MISMATCH : @NO, SCORE : @(matchScore * MATCH_BONUS)};
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            flipResult = @{FIRST_CARD : card.contents, SECOND_CARD : otherCard.contents, MISMATCH : @YES, SCORE : @(MISMATCH_PENALTY)};
                        }
                    }
                }
            
            if (!flipResult) flipResult = @{FIRST_CARD : card.contents, SCORE : @(FLIP_SCORE), MISMATCH : @NO};
            self.score -= FLIP_SCORE;
            
            [self.gameHistory addObject:flipResult];
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
