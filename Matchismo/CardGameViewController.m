//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Steven Tsang on 28/01/2013.
//  Copyright (c) 2013 Steven Tsang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;


@end

@implementation CardGameViewController

- (PlayingCardDeck *) deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    if (sender.selected)
    {
        PlayingCard *card = (PlayingCard *)[self.deck drawRandomCard];
        if (card)
        {
            [sender setTitle:[card contents] forState:UIControlStateSelected];
            self.flipCount++;
        }
        else
        {
            sender.selected = NO;
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"All out of cards!"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"Deal again!", nil];
            
            [myAlert show];
            
            //  Set deck to nil and flipCount back to 0
            self.deck = nil;
            self.flipCount = 0;
        }
    }
}

@end
