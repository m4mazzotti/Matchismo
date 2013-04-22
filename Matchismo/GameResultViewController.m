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
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) NSArray *allGameResults;
@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString *displayText = @"";
    
    for (GameResult *result in self.allGameResults) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %gs)\n", result.score, [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle], round(result.duration)];
    }
    
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.allGameResults = [GameResult allGameResults];
    [self updateUI];
}

- (IBAction)sortByDate
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}

- (IBAction)sortByScore
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}

- (IBAction)sortByDuration
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}

@end
