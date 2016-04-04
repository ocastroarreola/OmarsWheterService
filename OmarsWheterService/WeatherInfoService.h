//
//  WeatherInfoService.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfoService : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * zip;

-(instancetype)initWithName:(NSString*)name zip:(NSString*)zip;

@end
