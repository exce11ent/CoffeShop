//
//  EXMasterViewController.m
//  CoffeeShop
//
//  Created by MacUser1 on 1/14/13.
//  Copyright (c) 2013 Master of Code. All rights reserved.
//

#import "EXMasterViewController.h"
#import <RestKit/RestKit.h>
#import "Venue.h"
#define kCLIENTID "TIGUQRE2PLLF50S5V4FSAP5KJOKI1WJR2I5LFSLFAL2BZIJZ"
#define kCLIENTSECRET "SLY3Q2HRRKBB0XXPF0DPPTXO2PFIJZ4BV3CK3TJUOG3R14QW"

@interface EXMasterViewController () {
}
@end

@implementation EXMasterViewController

@synthesize data;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    RKRelationshipMapping *relation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping];
    
    [venueMapping addPropertyMapping:relation];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"response.venues"
                                                                                       statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [self sendRequest];
}

- (void) sendRequest {
    NSString *latLon = @"49.4,32";
    NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", @"20130115", @"v", nil];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //NSURL *url = [NSURL URLWithString:@"/venues/search"];
    [objectManager getObjectsAtPath:@"/v2/venues/search" parameters:queryParams
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSLog(@"objects[%d]", [[mappingResult array] count]);
                                data = [mappingResult array];
                                [self.tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"Error: %@", [error localizedDescription]);
                            }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Venue *venue = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [venue.name length] > 22 ? [venue.name substringToIndex:22] : venue.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fm", [venue.location.distance floatValue]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
