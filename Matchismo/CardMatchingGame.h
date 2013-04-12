//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 26/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck andGameMode:(NSInteger)gameMode;
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;
@end
