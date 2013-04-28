//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 21/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *displayMatch;
@property (weak, nonatomic) IBOutlet UITextView *displaySet;
@property (nonatomic) NSArray *allSetGameResults;
@property (nonatomic) NSArray *allMatchGameResults;
@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString *displayTextMatch = @"";
    
    for (GameResult *result in self.allMatchGameResults) {
        displayTextMatch = [displayTextMatch stringByAppendingFormat:@"Score: %d (%@, %gs)\n", result.score, [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle], round(result.duration)];
    }
    
    NSString *displayTextSet = @"";
    
    for (GameResult *result in self.allSetGameResults) {
        displayTextSet = [displayTextSet stringByAppendingFormat:@"Score: %d (%@, %gs)\n", result.score, [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle], round(result.duration)];
    }
    
    self.displayMatch.text = displayTextMatch;
    self.displaySet.text = displayTextSet;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.allSetGameResults = [GameResult allGameResultsForGameMode:@"SetGame"];
    self.allMatchGameResults = [GameResult allGameResultsForGameMode:@"MatchGame"];

    [self updateUI];
}

@end
