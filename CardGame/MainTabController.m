//
//  MainViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "MainTabController.h"

#import "GameViewController.h"
#import "HistoryViewController.h"

@interface MainTabController()
@end

@implementation MainTabController

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SegueToHistory"]) {
        HistoryViewController *vc = [segue destinationViewController];
        
        GameViewController *currentGame = self.selectedViewController;
        
        vc.history = currentGame.history;
    }
}

@end
