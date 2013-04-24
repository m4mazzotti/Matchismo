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

@interface SetCardGameViewController ()
@property (nonatomic) SetCardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISlider *gameProgressSlider;
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
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateDisabled];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setBackgroundColor:card.isFaceUp ? [UIColor blackColor] : [UIColor whiteColor]];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0 : 1;
    }

    self.gameProgressSlider.maximumValue = [self.game.gameHistory count] - 1;
    self.statusLabel.text = [self convertFlipResutToString:[self.game.gameHistory lastObject]];
    
    self.gameProgressSlider.value = self.gameProgressSlider.maximumValue;
    self.statusLabel.alpha = 1;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)convertFlipResutToString:(NSDictionary *)flipResult
{
    BOOL mismatch = [flipResult[MISMATCH] boolValue];
    NSString *firstCard = flipResult[FIRST_CARD];
    NSString *secondCard = flipResult[SECOND_CARD];
    NSString *thirdCard = flipResult[THIRD_CARD];
    NSInteger score = [flipResult[SCORE] intValue];
    
    if (mismatch) {
        return [NSString stringWithFormat:@"%@ & %@ & %@ don't match! %d points penalty", firstCard, secondCard, thirdCard, score];
    } else {
        if ([flipResult[NEW_GAME] boolValue]) {
            return @"";
        } else if (secondCard) {
            return [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points", firstCard, secondCard, thirdCard,score];
        } else {
            return [NSString stringWithFormat:@"Flipped up %@", firstCard];
        }
    }
}

- (IBAction)gameProgressValueChanged:(UISlider *)sender
{
    self.statusLabel.text = [self convertFlipResutToString:[self.game.gameHistory objectAtIndex:sender.value]];
    self.statusLabel.alpha = [self.game.gameHistory count] - 1 == sender.value ? 1 : 0.3;
}

@end