//
//  GameViewController.h
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//
// abstract class for all the game view controllers. Contains shared code, and manages history.

#import <UIKit/UIKit.h>

#import "CardMatchingGame.h"

@interface GameViewController : UIViewController
@property (strong, nonatomic) CardMatchingGame *game;
@end
