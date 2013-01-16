//
//  EXVenueCell.m
//  CoffeeShop
//
//  Created by MacUser1 on 1/16/13.
//  Copyright (c) 2013 Master of Code. All rights reserved.
//

#import "EXVenueCell.h"

@implementation EXVenueCell

@synthesize nameLabel, distanceLabel, checkinsLabel;

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
