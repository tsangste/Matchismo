//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Steven Tsang on 21/02/2013.
//  Copyright (c) 2013 Steven Tsang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *result;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSString *)result
{
    if (!_result) _result = [[NSString alloc] init];
    return _result;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    if (self = [super init])
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
    
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.result = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents
                                                                                                 , otherCard.contents
                                                                                                 , matchScore * MATCH_BONUS];
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.result = [NSString stringWithFormat:@"%@ & %@ dont match! %d point penalty!", card.contents
                                                                                                         , otherCard.contents
                                                                                                         , MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
