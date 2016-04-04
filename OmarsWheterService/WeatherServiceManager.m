//
//  WeatherServiceManager.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "WeatherServiceManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "WeatherZone.h"
#import "Constants.h"

#define kWeatherAPIKey @"b6c6de680b870250f0b90cd213061af9"
///kTimeThreshold set to 30 min

#define kProtocol @"http://"
#define kAPIBaseURL @"api.openweathermap.org/"
#define kBaseURL @"openweathermap.org/"
#define kResource @"data/2.5/weather"


@implementation WeatherServiceManager

@synthesize timeThreshold = _timeThreshold;


+(NSString*)pathForImage:(NSString*)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:imageName];
}

-(NSNumber *)timeThreshold {
    if (!_timeThreshold) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kWeatherEngineInitialized]) {
            [[NSUserDefaults standardUserDefaults] setInteger:30
                                                       forKey:kTimeThresholdValue];
            [[NSUserDefaults standardUserDefaults] setBool:YES
                                                    forKey:kWeatherEngineInitialized];
        }
        _timeThreshold = @([[NSUserDefaults standardUserDefaults]integerForKey:kTimeThresholdValue]);
    }
    return _timeThreshold;
}

-(void)setTimeThreshold:(NSNumber*)timeThreshold {
    _timeThreshold = timeThreshold;
    [[NSUserDefaults standardUserDefaults] setInteger:timeThreshold.integerValue
                                               forKey:kTimeThresholdValue];
}

+ (NSArray*)zipList {
    NSArray * zipList = @[];
    NSString * path =[[NSBundle mainBundle] pathForResource:@"ziplist"
                                                     ofType:@"json"];
    NSData * jsonData = [[NSData alloc] initWithContentsOfFile:path];
    if (jsonData) {
        NSError * e;
        zipList = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:0
                                                    error:&e];
        if (e) {
            zipList = @[];
        }
        zipList = [zipList sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return zipList;
}

-(BOOL)shouldUpdateWeatherDetailsWeather:(WeatherZone*)weather{
    NSInteger realTimeThreshold = 60 * self.timeThreshold.integerValue;
    if (!weather.lastUpdate || [[weather.lastUpdate dateByAddingTimeInterval:realTimeThreshold] compare:[NSDate date]] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

-(void)getWeatherImageForCode:(NSString*)code {
    NSString * baseURL = [NSString stringWithFormat:@"%@%@%@",kProtocol, kBaseURL, @"img/w/"];
    NSString * imageName = [NSString stringWithFormat:@"%@.png",code];
    baseURL = [baseURL stringByAppendingString:imageName];
    NSURLSessionConfiguration * conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:conf];
    NSURL *URL = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURL * destinationURL = [NSURL fileURLWithPath:[WeatherServiceManager pathForImage:imageName]];
    NSURLSessionTask * downloadImageTask = [manager downloadTaskWithRequest:request
                                                                   progress:nil
                                                                destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                    return destinationURL;
                                                                   }
                                                          completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                              if (error) {
                                                                  [self.delegate didFailingService:WeatherServicesImages
                                                                                             error:error
                                                                                           details:nil];
                                                              } else {
                                                                  [self.delegate didFinishGettingService:WeatherServicesImages
                                                                                                 details:nil];
                                                              }
                                                                   }];
    [downloadImageTask resume];
}

-(void)getWeatherDetailsForZip:(NSString*)zip {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * baseURL = [NSString stringWithFormat:@"%@%@%@",kProtocol, kAPIBaseURL, kResource];
    [manager GET:baseURL
      parameters:@{@"zip" : [[NSString alloc]initWithFormat:@"%@,us",zip],
                   @"appid" : kWeatherAPIKey,
                   @"units" : @"metric"}
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             //NSLog(@"task.originalRequest.allHTTPHeaderFields %@",task.originalRequest.allHTTPHeaderFields);
             //NSLog(@"task.originalRequest.URL %@",task.originalRequest.URL);
             NSLog(@"responseObject\n%@", responseObject);
             NSError * e;
             NSDictionary * details;
             if ([responseObject isKindOfClass:[NSData class]]) {
                 
                 details = [NSJSONSerialization JSONObjectWithData:responseObject
                                                           options:NSJSONReadingAllowFragments
                                                             error:&e];
                 
             } else if ([responseObject isKindOfClass:[NSDictionary class]]){
                 details = (NSDictionary*)responseObject;
             }
             if (e) {
                 [self.delegate didFailingService:WeatherServicesCurrentWeather
                                            error:e
                                          details:nil];
             } else {
                 [self.delegate didFinishGettingService:WeatherServicesCurrentWeather
                                                details:details];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [self.delegate didFailingService:WeatherServicesCurrentWeather
                                        error:error
                                      details:nil];
         }];
}

@end
