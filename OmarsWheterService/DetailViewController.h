//
//  DetailViewController.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/30/16.
//  Copyright (c) 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

