//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 23/4/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()
@property (nonatomic) SetCardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetCardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateCards];
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self convertCardIntoAttributedString:card.contents] forState:UIControlStateNormal];
        [cardButton setBackgroundColor:card.isFaceUp ? [UIColor blackColor] : [UIColor whiteColor]];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0 : 1;
    }
}

- (NSAttributedString *)convertCardIntoAttributedString:(NSString *)card
{
    NSArray *values = [card componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *string = @"";
    NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]];
    NSDictionary *dic = @{NSStrokeColorAttributeName : [colors objectAtIndex:[values[0] intValue]],
                          NSStrokeWidthAttributeName : @(-5),
                          NSForegroundColorAttributeName : [[colors objectAtIndex:[values[0] intValue]] colorWithAlphaComponent:[[@[@0.0f, @0.2f, @1.0f] objectAtIndex:[values[2] intValue]] floatValue]]};
    for (NSInteger i = 0; i <= [values[3] intValue]; i++) {
        string = [string stringByAppendingString:[@[@" ■", @" ▲", @" ●"] objectAtIndex:[values[1] intValue]]];
    }
    
    return [[NSAttributedString alloc] initWithString:string attributes:dic];
}

- (NSAttributedString *)convertFlipResutToString:(NSDictionary *)flipResult
{
    BOOL mismatch = [flipResult[MISMATCH] boolValue];
    NSString *firstCard = flipResult[FIRST_CARD];
    NSString *secondCard = flipResult[SECOND_CARD];
    NSString *thirdCard = flipResult[THIRD_CARD];
    NSInteger score = [flipResult[SCORE] intValue];
    NSAttributedString *separator = [[NSAttributedString alloc] initWithString:@" &" ];
    if (mismatch) {
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:[self convertCardIntoAttributedString:firstCard]];
        [result appendAttributedString:separator];
        [result appendAttributedString:[self convertCardIntoAttributedString:secondCard]];
        [result appendAttributedString:separator];
        [result appendAttributedString:[self convertCardIntoAttributedString:thirdCard]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d points penalty", score]]];
        return result;
    } else {
        if ([flipResult[NEW_GAME] boolValue]) {
            return [[NSAttributedString alloc] initWithString:@""];
        } else if (secondCard) {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [result appendAttributedString:[self convertCardIntoAttributedString:firstCard]];
            [result appendAttributedString:separator];
            [result appendAttributedString:[self convertCardIntoAttributedString:secondCard]];
            [result appendAttributedString:separator];
            [result appendAttributedString:[self convertCardIntoAttributedString:thirdCard]];
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points", score]]];
            return result;
        } else {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
            [result appendAttributedString:[self convertCardIntoAttributedString:firstCard]];
            return result;
        }
    }
}

@end