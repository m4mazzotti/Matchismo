//
//  PlayingCard.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 9/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuit;
+ (NSInteger)maxRank;
@end
