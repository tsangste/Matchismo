//
//  Deck.m
//  Matchismo
//
//  Created by Steven Tsang on 28/01/2013.
//  Copyright (c) 2013 Steven Tsang. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards; // of Cards

@end

@implementation Deck

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count)
    {
        unsigned int random = arc4random() % self.cards.count;
        randomCard = self.cards[random];
        [self.cards removeObjectAtIndex:random];
    }
    
    return randomCard;
}

@end
