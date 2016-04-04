//
//  DetailViewController.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/30/16.
//  Copyright (c) 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "DetailViewController.h"
#import "WeatherZone+CoreDataProperties.h"
#import "CoreDataManager.h"
#import "WeatherServiceManager.h"
#import "Weather.h"

@interface DetailViewController ()<WeatherServiceManagerDelegate>

@property (nonatomic, strong) WeatherServiceManager * weatherManager;


@property (weak, nonatomic) IBOutlet UILabel *temp_min;

@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *weatherSum;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *min_temp;
@property (weak, nonatomic) IBOutlet UILabel *max_temp;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *wind_speed;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end

@implementation DetailViewController

-(WeatherServiceManager *)weatherManager {
    if (!_weatherManager) {
        _weatherManager = [[WeatherServiceManager alloc]init];
        _weatherManager.delegate = self;
    }
    return _weatherManager;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(WeatherZone*)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
        //show loading
        if ([self.weatherManager shouldUpdateWeatherDetailsWeather:_detailItem]) {
            [self.weatherManager getWeatherDetailsForZip:_detailItem.zip];
        }
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.cityName.text = self.detailItem.name;
        self.weatherSum.text = @"";
        self.temp.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.temp];
        self.min_temp.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.temp_min];
        self.max_temp.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.temp_max];
        self.pressure.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.pressure];
        self.humidity.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.humidity];
        self.wind_speed.text = [NSString stringWithFormat:@"0.1%f",self.detailItem.windSpeed];
        [self setImage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)setImage {
    if (self.detailItem.weather.anyObject.icon) {
        NSString * imageName = [NSString stringWithFormat:@"%@.png",self.detailItem.weather.anyObject.icon];
        NSString * imagePath = [WeatherServiceManager pathForImage:imageName];
        UIImage * weatherIcon = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        if (weatherIcon) {
            self.weatherIcon.image = weatherIcon;
        } else {
            [self.weatherManager getWeatherImageForCode:self.detailItem.weather.anyObject.icon];
        }
    }
}

#pragma mark - WeatherServiceManagerDelegate

-(void)didFinishGettingService:(WeatherServices)service details:(NSDictionary *)details {
    if (service == WeatherServicesCurrentWeather) {
        [EKManagedObjectMapper fillObject:self.detailItem
               fromExternalRepresentation:details
                              withMapping:[WeatherZone objectMapping]
                   inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
        self.detailItem.lastUpdate = [NSDate date];
        [[CoreDataManager manager]saveContext];
        [self configureView];
        //hide loading
    } else if(service == WeatherServicesImages) {
        [self setImage];
    }
}

-(void)didFailingService:(WeatherServices)service error:(NSError *)error details:(NSDictionary *)details {
    NSLog(@"error\n%@",error);
}

@end
