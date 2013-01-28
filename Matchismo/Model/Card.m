//
//  Card.m
//  Matchismo
//
//  Created by Steven Tsang on 28/01/2013.
//  Copyright (c) 2013 Steven Tsang. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end
