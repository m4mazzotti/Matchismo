//
//  PlayingCard.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 9/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    NSUInteger score = 0;
    
    for(PlayingCard *card in otherCards)
    {
        if ([card.suit isEqualToString:self.suit]) {
            score += 2;
        } else if (card.rank == self.rank) {
            score += 4;
        }
    }
    
    NSInteger otherCardsCount = [otherCards count];
    if(otherCardsCount > 1)
    {
        NSRange range;
        range.location = 1;
        range.length = otherCardsCount - 1;
        score += [otherCards[0] match:[otherCards subarrayWithRange:range]];
    }
    
    return score;
}

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuit] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuit
{
    static NSArray *validSuit = nil;
    if (!validSuit) validSuit = @[@"♥", @"♦", @"♠", @"♣"];
    return validSuit;
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

+ (NSInteger)maxRank
{
    return [self rankStrings].count - 1;
}
@end
