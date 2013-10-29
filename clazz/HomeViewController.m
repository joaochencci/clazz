//
//  HomeViewController.m
//  clazz
//
//  Created by João Victor Chencci on 25/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "TaskViewController.h"
#import "User.h"
#import "Task.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *schoolCell;
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        User *sessionUser = [User sessionUser];
//        self.tasks = [sessionUser  tasks];
        
        self.tasks = [[self tasks] initWithObjects:@"Dois", @"Tres",@"Quatro", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.homeTableView){
        return [self.tasks count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [[HomeTableViewCell alloc] init];
    
    if (tableView == self.homeTableView) {
        static NSString *CellIdentifier = @"homeTableCell";  //INSERIR ESSE ID NO STORYBOARD
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[HomeTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        cell.taskName.text = [self.tasks
                              objectAtIndex: [indexPath row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.homeTableView) {
        static NSString *taskSegue = @"taskSegue";
        self.index = indexPath;
        
        [self performSegueWithIdentifier:taskSegue sender:self];
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if( [segue.identifier isEqualToString:@"taskSegue"]) {
        TaskViewController *nextView = segue.destinationViewController;
        
        Task *sessionTask = [self.tasks objectAtIndex:self.index.row];
        
        [nextView setTask:sessionTask];
    }
    
}
@end
