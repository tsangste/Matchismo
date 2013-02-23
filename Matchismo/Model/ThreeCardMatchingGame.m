//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Steven Tsang on 22/02/2013.
//  Copyright (c) 2013 Steven Tsang. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *result;

@end

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

@implementation ThreeCardMatchingGame

- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
    
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
            for (Card *card in self.cards)
            {
                if (card.isFaceUp && !card.isUnplayable)
                {
                    [selectedCards addObject:card];
                }
            }
            
            if (1 == [selectedCards count])
            {
                int matchScore = [card match:selectedCards];
                if (!matchScore)
                {
                    for (Card *otherCard in selectedCards)
                    {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.result = [NSString stringWithFormat:@"Mismatch! %d point penalty!", MISMATCH_PENALTY];
                }
            }
            else if (2 == [selectedCards count])
            {
                int matchScore = [card match:selectedCards];
                if (matchScore)
                {
                    for (Card *otherCard in selectedCards)
                    {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    self.result = [NSString stringWithFormat:@"Matched for %d points", matchScore * MATCH_BONUS];
                }
                else
                {
                    for (Card *otherCard in selectedCards)
                    {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.result = [NSString stringWithFormat:@"Mismatch! %d point penalty!", MISMATCH_PENALTY];
                }

            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
