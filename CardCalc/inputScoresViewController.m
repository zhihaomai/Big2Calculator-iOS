//
//  inputScoresViewController.m
//  CardCalc
//
//  Created by Zee on 2013-02-01.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import "inputScoresViewController.h"
#import "cardObject.h"
#import "cardCalcCell.h"

@interface inputScoresViewController ()

@end

@implementation inputScoresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Scores"];
    
    [[cardObject instance] emptyPlayerScores];
    
    [scoresTable setDelegate:self];
    [scoresTable setDataSource:self];
    scoresTable.contentInset=UIEdgeInsetsMake(0,0,274,0);
    
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancelButtonPressed{
    NSLog (@"Cancel pressed");
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void) doneButtonPressed{
    
}

#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cardObject instance].numOfPlayers;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    cardCalcCell *cell = (cardCalcCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[cardCalcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setPlayerNumber:indexPath.row];
        
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 40)];
        [temp setText:[NSString stringWithFormat:@"Player %d", indexPath.row+1]];
        [temp sizeToFit];
        [cell setPlayerLabel:temp];
        [[cell contentView] addSubview:[cell playerLabel]];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, temp.frame.origin.y + temp.frame.size.height, 100, 40)];
        [scoreLabel setText:@"Score:"];
        [scoreLabel sizeToFit];
        [cell addSubview:scoreLabel];
        
        UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, (CELL_HEIGHT - 30)/2, 80, 30)];
        [numberField setTag:[cell playerNumber]];
        [numberField setDelegate:self];
        [numberField  setText:@"0"];
        [numberField setBorderStyle:UITextBorderStyleRoundedRect];
        [numberField setKeyboardType:UIKeyboardTypeNumberPad];
        [numberField setKeyboardAppearance:UIKeyboardAppearanceDefault];
        [cell setScoreField:numberField];
        [[cell contentView] addSubview:[cell scoreField]];
    }
    
    return cell;
}

#pragma mark - Textfield delegate

- (void) textFieldDidEndEditing:(UITextField *)textField{
    NSLog (@"%ld", (long)textField.tag);
    if (textField.text.integerValue==0){
        [textField setText:@"0"];
    }
    NSNumber* newScore = [NSNumber numberWithInt:textField.text.integerValue];
    [[[cardObject instance] playerScores] replaceObjectAtIndex:textField.tag withObject:newScore];
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField setText:@""];
    
    cardCalcCell* lastCell = (cardCalcCell*) [[textField superview] superview];
    [scoresTable scrollToRowAtIndexPath:[scoresTable indexPathForCell:lastCell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.view addGestureRecognizer:tapped];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [scoresTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void) dismissKeyboard{
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:tapped];
}

@end
