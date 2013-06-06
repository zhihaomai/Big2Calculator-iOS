//
//  inputScoresViewController.h
//  CardCalc
//
//  Created by Zee on 2013-02-01.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_HEIGHT 78.0

@interface inputScoresViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    IBOutlet UITableView* scoresTable;
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *doneButton;
    UITapGestureRecognizer* tapped;
}

@end
