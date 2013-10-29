//
//  HomeTableViewCell.m
//  clazz
//
//  Created by João Victor Chencci on 25/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

@synthesize taskName = _taskName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
