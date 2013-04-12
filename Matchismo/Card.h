//
//  Card.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 9/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (getter = isFaceUp) BOOL faceUp;
@property (getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;
@end
