//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 23/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "SetCardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_SCORE 1

@implementation SetCardMatchingGame

-(void)flipCardAtIndex:(NSUInteger)index
{
    NSDictionary *flipResult = nil;
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    for (Card *otherCard2 in self.cards) {
                        if (otherCard == otherCard2) continue;
                        if (otherCard2.isFaceUp && !otherCard2.isUnplayable) {
                            NSUInteger matchScore = [card match:@[otherCard, otherCard2]];
                            if (matchScore) {
                                otherCard2.unplayable = YES;
                                otherCard.unplayable = YES;
                                card.unplayable = YES;
                                self.score += matchScore * MATCH_BONUS;
                                flipResult = @{FIRST_CARD : card.contents, SECOND_CARD : otherCard.contents, THIRD_CARD : otherCard2.contents, MISMATCH : @NO, SCORE : @(matchScore * MATCH_BONUS)};
                            } else {
                                otherCard2.faceUp = NO;
                                otherCard.faceUp = NO;
                                card.faceUp = YES;
                                self.score -= MISMATCH_PENALTY;
                                flipResult = @{FIRST_CARD : card.contents, SECOND_CARD : otherCard.contents, THIRD_CARD : otherCard2.contents, MISMATCH : @YES, SCORE : @(MISMATCH_PENALTY)};
                            }
                        }
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
