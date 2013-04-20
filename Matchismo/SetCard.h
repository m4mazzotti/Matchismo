//
//  SetCard.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 19/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSInteger number;
@property (nonatomic) NSInteger symbol;
@property (nonatomic) NSInteger shading;
@property (nonatomic) NSInteger color;

+ (NSInteger) maxNumber;
+ (NSInteger) maxSymbol;
+ (NSInteger) maxShading;
+ (NSInteger) maxColor;

- (id)initSetCardWithNumber:(NSInteger)number Symbol:(NSInteger)symbol Shading:(NSInteger)shading AndColor:(NSInteger)color;

@end
