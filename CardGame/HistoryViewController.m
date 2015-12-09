//
//  HistoryViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.historyTextView.attributedText = self.history;
}

@end
