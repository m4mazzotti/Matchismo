//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 26/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *status;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger gameMode;
@end

@implementation CardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_SCORE 1

- (NSString *)status
{
    if (!_status) _status = @"";
    return _status;
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck andGameMode:(NSInteger)gameMode
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
        self.gameMode = gameMode;
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.status = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            if (self.gameMode == 2) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        NSUInteger matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            self.status = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.status = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        }
                    }
                }
            } else if (self.gameMode == 3) {
                for (Card *otherCard1 in self.cards) {
                    if (otherCard1.isFaceUp && !otherCard1.isUnplayable) {
                        for (Card *otherCard2 in self.cards) {
                            if (otherCard1 == otherCard2) continue;
                            if (otherCard2.isFaceUp && !otherCard2.isUnplayable) {
                                NSUInteger matchScore = [card match:@[otherCard1, otherCard2]];
                                if (matchScore) {
                                    otherCard1.unplayable = YES;
                                    otherCard2.unplayable = YES;
                                    card.unplayable = YES;
                                    self.score += matchScore * MATCH_BONUS;
                                    self.status = [NSString stringWithFormat:@"Matched %@ & %@ & %@for %d points", card.contents, otherCard1.contents, otherCard2.contents, matchScore * MATCH_BONUS];
                                } else {
                                    otherCard2.faceUp = NO;
                                    self.score -= MISMATCH_PENALTY;
                                    self.status = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d points penalty", card.contents, otherCard1.contents, otherCard2.contents, MISMATCH_PENALTY];
                                }
                            }
                            
                        }
                    }
                }
            }
            self.score -= FLIP_SCORE;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
