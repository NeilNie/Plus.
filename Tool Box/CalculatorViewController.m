//
//  SpeechViewController.m
//  
//
//  Created by Yongyang Nie on 9/11/16.
//
//

#import "CalculatorViewController.h"

#pragma mark - UI Constants

#define TABLE_TOP_SPACE 20
#define DISPLAY_HEIGHT 70
#define BUTTON_HEIGHT 60
#define BUTTON_ROW_COUNT 5
#define BUTTON_SPACING 3;
#define BUTTONS_PER_ROW 4

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

#pragma mark IBActions Methods

-(IBAction)selectedNumber:(id)sender{
    
    NSString *string = [(UIButton *)sender titleLabel].text;
    self.selectString = [self.selectString stringByAppendingString:string];
    self.largeResultLabel.text = self.selectString;
}

-(IBAction)selectedPercent:(id)sender{
    
    if (![self.selectString isEqualToString:@""]) {
        double n = [self.selectString doubleValue] * 100.0;
        self.largeResultLabel.text = [[self extractString:[NSString stringWithFormat:@"%f", n]] stringByAppendingString:@"%"];
    }
}

-(IBAction)selectedSquare:(id)sender{
    
    if (![self.selectString isEqualToString:@""]) {
        double n = [self.selectString doubleValue] * [self.selectString doubleValue];
        self.largeResultLabel.text = [self extractString:[NSString stringWithFormat:@"%f", n]];
    }
}

-(IBAction)selectedOperation:(id)sender {
    
    NSString *string = [(UIButton *)sender titleLabel].text;
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    else
        [self calculate:method];
    
    // set the operation code
    if ([string isEqualToString:@"+"]) {
        method = 4;
    } else if ([string isEqualToString:@"-"]) {
        method = 3;
    } else if ([string isEqualToString:@"×"]) {
        method = 1;
    } else if ([string isEqualToString:@"/"]) {
        method = 2;
    }
    
    // set initial value and add that to the tableView
    if (self.initialValue == nil) {
        self.initialValue = [[NSNumber alloc] initWithDouble:[self.selectString doubleValue]];
        Result *initialResult = [[Result alloc] initWithOperation:-1 andValue:self.initialValue];
        [self addNewResult:initialResult];
    }
    
    self.largeResultLabel.text = [self extractString:[NSString stringWithFormat:@"%f", self.runningTotal]];
    self.selectString = @"";
    
}

-(IBAction)equals:(id)sender{
    
    if (self.runningTotal == 0)
        self.runningTotal = [self.selectString doubleValue];
    
    else
        [self calculate:method];
    
    method = 0;
    self.selectString = @"0";
    self.largeResultLabel.text = [self extractString:[NSString stringWithFormat:@"%f", self.runningTotal]];
}


-(IBAction)allClear:(id)sender{
    
    method = 0;
    self.runningTotal = 0;
    self.selectString = @"";
    self.largeResultLabel.text = [NSString stringWithFormat:@"0"];
}

#pragma mark - UITableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID" forIndexPath:indexPath];
    Result *result = self.resultsArray[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.operationSignLabel.hidden = YES;
        cell.numberLabel.text = [self.initialValue stringValue];

    } else {
        cell.operationSignLabel.hidden = NO;
        cell.numberLabel.text = [result.value stringValue];

        switch (result.operation) {
            case 0:
                cell.operationSignLabel.text = @"+";
                break;
            case 1:
                cell.operationSignLabel.text = @"-";
                break;
            case 2:
                cell.operationSignLabel.text = @"✕";
                break;
            case 3:
                cell.operationSignLabel.text = @"÷";
                break;
                
            default:
                break;
        }
    }

    return cell;
}

#pragma mark - Private Helpers

-(NSString *)extractString:(NSString *)number{
    
    NSString *string = number;
    for (int i = (int)number.length - 1; i >= 0; i--) {
        if ([[NSString stringWithFormat:@"%c", [number characterAtIndex:i]] isEqualToString:@"0"]) {
            string = [number substringToIndex:i-1]; // remove the dot
        }else{
            break;
        }
    }
    
    return string;
}

-(void)calculate:(int)method{
    
    Result *result;
    
    switch (method) {
        case 1:
            self.runningTotal = self.runningTotal * [self.selectString doubleValue];
            result = [[Result alloc] initWithOperation:2 andValue:[NSNumber numberWithDouble:[self.selectString doubleValue]]];
            break;
        case 2:
            self.runningTotal = self.runningTotal / [self.selectString doubleValue];
            result = [[Result alloc] initWithOperation:3 andValue:[NSNumber numberWithDouble:[self.selectString doubleValue]]];
            break;
        case 3:
            self.runningTotal = self.runningTotal - [self.selectString doubleValue];
            result = [[Result alloc] initWithOperation:1 andValue:[NSNumber numberWithDouble:[self.selectString doubleValue]]];
            break;
        case 4:
            self.runningTotal = self.runningTotal + [self.selectString doubleValue];
            result = [[Result alloc] initWithOperation:0 andValue:[NSNumber numberWithDouble:[self.selectString doubleValue]]];
            break;
        default:
            break;
    }
    
    if (method > 0) {
        [self addNewResult:result];
    }
}

-(void)addNewResult:(Result *)result {
    
    [self.resultsArray addObject:result];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.resultsArray count] - 1 inSection:0];
    [self.resultsTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - View Helper Methods

-(void)setShadowforView:(UIView *)view{
    
    view.layer.cornerRadius = 5;
    view.layer.shadowRadius = 2.0f;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1.0f, 3.0f);
    view.layer.shadowOpacity = 0.6f;
    view.layer.masksToBounds = YES;
}

-(void)setupViews{
    
    for (int i = 0; i < self.buttons.count; i++) {
        
        UIButton *button = self.buttons[i];
        [self setShadowforView:button];
        
        // Calculate the width of the buttons
        NSLayoutConstraint *width = [NSLayoutConstraint
                                     constraintWithItem:button
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:0
                                     constant:((int)self.view.frame.size.width - 3 * 3)  / 4];
        [button addConstraint:width];
    }
}

- (void)runAds {
    
    if(areAdsRemoved == YES){
        self.banner.hidden = YES;
    }else{
        self.banner.adUnitID = @"ca-app-pub-7942613644553368/1714159132";
        self.banner.rootViewController = self;
        [self.banner loadRequest:[GADRequest request]];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
    
    self.resultsArray = [[NSMutableArray alloc] init];
    self.selectString = @"";
    
    [self runAds];
    [self setupViews];
    [self setShadowforView:self.mainView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
