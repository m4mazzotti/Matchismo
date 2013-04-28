//
//  GameResult.h
//  Matchismo
//
//  Created by Marcelo Mazzotti on 21/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) NSInteger score;

+ (NSArray *)allGameResultsForGameMode:(NSString *)gameMode;
+ (void)deleteGameResult:(NSString *)gameMode;

- (id)initForGameMode:(NSString *)gameMode;

- (NSComparisonResult)compareDate:(GameResult *)aGameResuts;
- (NSComparisonResult)compareScore:(GameResult *)aGameResuts;
- (NSComparisonResult)compareDuration:(GameResult *)aGameResuts;

@end
