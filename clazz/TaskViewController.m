//
//  TaskViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 30/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *taskDiscipline;
@property (weak, nonatomic) IBOutlet UILabel *taskTest;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;
@property (weak, nonatomic) IBOutlet UILabel *taskInitialDate;
@property (weak, nonatomic) IBOutlet UILabel *taskFinalDate;
@property (weak, nonatomic) IBOutlet UISlider *percentageSlider;
@property (weak, nonatomic) IBOutlet UILabel *percentageConcluded;
@property (nonatomic) UIColor *color;

@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.taskName.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    self.color = self.percentageConcluded.textColor;
    self.taskDiscipline.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:1 alpha:1];
    self.taskTest.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)percentageSelected:(id)sender {
    
    self.percentageConcluded.text = [[NSNumber numberWithFloat:roundf(100*self.percentageSlider.value)] stringValue];
    if (self.percentageSlider.value == 1) self.percentageConcluded.textColor = [UIColor redColor];
    else if (self.percentageSlider.value >= 0.5) self.percentageConcluded.textColor = [UIColor colorWithRed:1 green:0.8 blue:0.2 alpha:1];
    else self.percentageConcluded.textColor = self.color;
}

@end
