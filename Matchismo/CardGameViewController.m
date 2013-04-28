//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Marcelo Mazzotti on 8/2/13.
//  Copyright (c) 2013 Marcelo Mazzotti. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) NSInteger flipCount;
@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISlider *gameProgressSlider;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] initForGameMode:[self.game isMemberOfClass:[CardMatchingGame class]] ? @"MatchGame" : @"SetGame"];
    return _gameResult;
}

-(void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %i", self.flipCount];
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateCards];
}

- (IBAction)dealButtonPressed:(UIButton *)sender
{
    self.flipCount = 0;
    self.gameProgressSlider.maximumValue = 0;
    self.game = nil;
    self.gameResult = nil;
    
    [self updateUI];
}

- (void)updateUI
{
    [self updateCards];
    
    self.gameProgressSlider.maximumValue = [self.game.gameHistory count] - 1;
    self.statusLabel.attributedText = [self convertFlipResutToString:[self.game.gameHistory lastObject]];
    
    self.gameProgressSlider.value = self.gameProgressSlider.maximumValue;
    self.statusLabel.alpha = 1;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        [cardButton setImage:card.isFaceUp ? nil : [UIImage imageNamed:@"CardBack.png"] forState:UIControlStateNormal];
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1;
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.gameResult.score = self.game.score;
    [self updateUI];
}

- (IBAction)gameProgressValueChanged:(UISlider *)sender
{
    self.statusLabel.attributedText = [self convertFlipResutToString:[self.game.gameHistory objectAtIndex:sender.value]];
    self.statusLabel.alpha = [self.game.gameHistory count] - 1 == sender.value ? 1 : 0.3;
}

- (NSAttributedString *)convertFlipResutToString:(NSDictionary *)flipResult
{
    BOOL mismatch = [flipResult[MISMATCH] boolValue];
    NSString *firstCard = flipResult[FIRST_CARD];
    NSString *secondCard = flipResult[SECOND_CARD];
    NSInteger score = [flipResult[SCORE] intValue];
    
    if (mismatch) {
        return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty", firstCard, secondCard, score]];
    } else {
        if ([flipResult[NEW_GAME] boolValue]) {
            return [[NSAttributedString alloc] initWithString:@""];
        } else if (secondCard) {
            return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched %@ & %@ for %d points", firstCard, secondCard, score]];
        } else {
            return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flipped up %@", firstCard]];
        }
    }
}

@end
