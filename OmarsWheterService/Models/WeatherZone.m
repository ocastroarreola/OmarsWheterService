//
//  WeatherZone.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "WeatherZone.h"
#import "Weather.h"

@implementation WeatherZone

+(EKManagedObjectMapping *)objectMapping {
    return [EKManagedObjectMapping mappingForEntityName:@"WeatherZone"
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping hasMany:[Weather class]
                                                        forKeyPath:@"weather"
                                                       forProperty:@"weather"
                                                 withObjectMapping:[Weather objectMapping]];
                                                  [mapping mapPropertiesFromArray:@[@"id", @"cod", @"name"]];
                                                  [mapping mapKeyPath:@"coord.lon"
                                                           toProperty:@"lon"];
                                                  [mapping mapKeyPath:@"coord.lat"
                                                           toProperty:@"lat"];
                                                  
                                                  [mapping mapKeyPath:@"wind.deg"
                                                           toProperty:@"windDeg"];
                                                  [mapping mapKeyPath:@"wind.speed"
                                                           toProperty:@"windSpeed"];
                                                  
                                                  [mapping mapKeyPath:@"main.pressure"
                                                           toProperty:@"pressure"];
                                                  [mapping mapKeyPath:@"main.humidity"
                                                           toProperty:@"humidity"];
                                                  [mapping mapKeyPath:@"main.temp"
                                                           toProperty:@"temp"];
                                                  [mapping mapKeyPath:@"main.temp_min"
                                                           toProperty:@"temp_min"];
                                                  [mapping mapKeyPath:@"main.temp_max"
                                                           toProperty:@"temp_max"];
                                              }];
}

@end
