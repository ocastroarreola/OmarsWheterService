//
//  Weather.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "Weather.h"
#import "WeatherZone.h"

@implementation Weather

+(EKManagedObjectMapping *)objectMapping {
    return  [EKManagedObjectMapping mappingForEntityName:@"Weather"
                                               withBlock:^(EKManagedObjectMapping *mapping) {
                                                   [mapping mapPropertiesFromArray:@[@"id", @"main", @"icon"]];
                                                   [mapping mapKeyPath:@"description"
                                                            toProperty:@"desc"];
                                               }];
}

@end
