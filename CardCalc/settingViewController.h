//
//  settingViewController.h
//  CardCalc
//
//  Created by Zee on 2013-02-01.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingViewController : UIViewController

@property IBOutlet UISegmentedControl *numOfPlayerControl;
@property IBOutlet UISegmentedControl *amountBet;
@property IBOutlet UIScrollView *aboutView;
@property IBOutlet UIButton *resetButton;

@end
