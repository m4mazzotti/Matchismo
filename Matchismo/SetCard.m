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

-(NSString *)contents
{
    return [NSString stringWithFormat:@"%i %i %i %i",self.color, self.symbol, self.shading, self.number];
}

- (NSInteger)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        NSInteger sumSymbol = self.symbol;
        NSInteger sumNumber = self.number;
        NSInteger sumShading = self.shading;
        NSInteger sumColor = self.color;
        for (SetCard *card in otherCards) {
            sumSymbol += card.symbol;
            sumNumber += card.number;
            sumShading += card.shading;
            sumColor += card.color;
        }
        
        score = (sumSymbol % 3 == 0 && sumNumber % 3 == 0 && sumShading % 3 == 0 && sumColor % 3 == 0) ? 10 : 0;
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
