//
//  Venue.h
//  CoffeeShop
//
//  Created by MacUser1 on 1/14/13.
//  Copyright (c) 2013 Master of Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Stats.h"

@interface Venue : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) Stats *stats;

@end
