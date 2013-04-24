//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 19/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSInteger number = 0; number < [SetCard maxNumber]; number++) {
            for (NSInteger symbol = 0; symbol < [SetCard maxSymbol]; symbol++) {
                for (NSInteger shading = 0; shading < [SetCard maxShading]; shading++) {
                    for (NSInteger color = 0; color < [SetCard maxColor]; color++) {
                        SetCard *card = [[SetCard alloc] initSetCardWithNumber:number Symbol:symbol Shading:shading AndColor:color];
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}
@end
