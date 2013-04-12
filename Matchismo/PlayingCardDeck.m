//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 9/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuit]) {
            for (NSInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}
@end
