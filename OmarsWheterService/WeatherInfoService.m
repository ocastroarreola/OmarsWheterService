//
//  WeatherInfoService.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "WeatherInfoService.h"

@implementation WeatherInfoService

-(instancetype)initWithName:(NSString*)name zip:(NSString*)zip {
    self = [self init];
    if (self) {
        self.name = name;
        self.zip = zip;
    }
    return self;
}

@end
