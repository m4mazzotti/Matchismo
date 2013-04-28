//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 28/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameResult.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (IBAction)clearGameResults
{
    [GameResult deleteGameResult:@"SetGame"];
    [GameResult deleteGameResult:@"MatchGame"];
}


@end
