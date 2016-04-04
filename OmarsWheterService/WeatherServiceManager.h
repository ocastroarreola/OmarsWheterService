//
//  WeatherServiceManager.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherZone;

typedef NS_ENUM(NSUInteger, WeatherServices) {
    WeatherServicesImages,
    WeatherServicesForecast,
    WeatherServicesCurrentWeather
};

@protocol WeatherServiceManagerDelegate <NSObject>

-(void)didFinishGettingService:(WeatherServices)service details:(NSDictionary*)details;
-(void)didFailingService:(WeatherServices)service error:(NSError*)error details:(NSDictionary*)details;

@end

@interface WeatherServiceManager : NSObject

@property (nonatomic, weak) id <WeatherServiceManagerDelegate> delegate;
@property (nonatomic) NSNumber* timeThreshold;//default to 30 mins

+(NSString*)pathForImage:(NSString*)imageName;
-(void)getWeatherDetailsForZip:(NSString*)zip;
-(void)getWeatherImageForCode:(NSString*)code;
-(BOOL)shouldUpdateWeatherDetailsWeather:(WeatherZone*)weather;
+(NSArray*)zipList;

@end
