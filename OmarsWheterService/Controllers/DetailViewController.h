//
//  DetailViewController.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/30/16.
//  Copyright (c) 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "BaseTableViewController.h"
@class WeatherZone;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) WeatherZone* detailItem;

@end

