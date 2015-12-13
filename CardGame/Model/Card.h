//
//  Card.h
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSArray *attributes;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int) matchCards:(NSArray *)cards;
- (int) match:(NSArray *)otherCards;
@end
