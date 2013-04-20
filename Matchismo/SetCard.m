//
//  SetCard.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 19/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (id)initSetCardWithNumber:(NSInteger)number Symbol:(NSInteger)symbol Shading:(NSInteger)shading AndColor:(NSInteger)color
{
    self = [super init];
    if (self) {
        if (number > [SetCard maxNumber] || symbol > [SetCard maxSymbol] || shading > [SetCard maxShading] || color > [SetCard maxColor]) return nil;
        
        self.number = number;
        self.symbol = symbol;
        self.shading = shading;
        self.color = color;
    }
    return self;
}

- (NSInteger)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        SetCard *otherCard1 = otherCards[0];
        SetCard *otherCard2 = otherCards[1];
        if (self.number == otherCard1.number && self.number == otherCard2.number) score += 2;
        if (self.symbol == otherCard1.symbol && self.symbol == otherCard2.symbol) score += 2;
        if (self.shading == otherCard1.shading && self.shading == otherCard2.shading) score += 2;
        if (self.color == otherCard1.color && self.color == otherCard2.color) score += 2;
    }
    
    return score;
}

+ (NSInteger)maxNumber
{
    return 3;
}

+ (NSInteger)maxSymbol
{
    return 3;
}

+(NSInteger)maxShading
{
    return 3;
}

+(NSInteger)maxColor
{
    return 3;
}
@end
