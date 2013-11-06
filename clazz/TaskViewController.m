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

@property (strong, nonatomic) NSNumber *position;
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
    
//    self.percentageSlider.value = (float)0.3;
//    self.percentageConcluded.text = [[NSNumber numberWithFloat:roundf(100*self.percentageSlider.value)] stringValue];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
    
    self.taskDescription.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.color = self.percentageConcluded.textColor;

//    self.taskName.textColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
//    self.taskDiscipline.textColor = [UIColor colorWithRed:0.4 green:0.6 blue:1 alpha:1];
//    self.taskTest.textColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    
    [self.taskName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [self.taskDiscipline setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.taskTest setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    
//    [[self.taskTest textColor] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    _position = _taskDetailModel[0];
    _taskName.text = _taskDetailModel[1];
    _taskDescription.text = _taskDetailModel[2];
    _taskDiscipline.text = _taskDetailModel[3];
    _taskInitialDate.text = _taskDetailModel[4];
    _taskFinalDate.text = _taskDetailModel[5];
    
//    _taskTest.text = _taskDetailModel[2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)percentageSelected:(id)sender {
    
    self.percentageConcluded.text = [[NSNumber numberWithFloat:roundf(100*self.percentageSlider.value)] stringValue];
    
    //TODO : buscar objeto na posição de "position", inserir o novo valor da porcentagem, salvar de volta
    
    self.percentageConcluded.textColor = self.color;
}

@end
