//
//  TaskViewController.m
//  clazz
//
//  Created by João Victor Chencci on 25/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *taskDiscipline;
@property (weak, nonatomic) IBOutlet UILabel *taskTest;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;
@property (weak, nonatomic) IBOutlet UILabel *initialDate;
@property (weak, nonatomic) IBOutlet UILabel *finalDate;
@property (weak, nonatomic) IBOutlet UISlider *concludedSlider;
@property (weak, nonatomic) IBOutlet UILabel *percentageConcluded;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
