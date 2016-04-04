//
//  ZipListTableViewController.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "ZipListTableViewController.h"
#import "CoreDataManager.h"
#import "WeatherServiceManager.h"
#import "WeatherZone+CoreDataProperties.h"

@interface ZipListTableViewController ()

@property(nonatomic, strong) NSArray * dataSource;
@property(nonatomic, strong) NSMutableArray * selectedItems;

@end

@implementation ZipListTableViewController

-(NSArray*)dataSource {
    if (!_dataSource) {
        _dataSource = [WeatherServiceManager zipList];
    }
    return _dataSource;
}

-(NSMutableArray*)selectedItems {
    if (!_selectedItems) {
        _selectedItems = [[NSMutableArray alloc]init];
    }
    return _selectedItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveWeatherZips:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                            target:self
                                                                            action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = YES;
}

-(void)saveWeatherZips:(UIBarButtonItem*)button {
    if (self.selectedItems.count) {
        BOOL followSegue = self.selectedItems.count == 1;
        [[CoreDataManager manager] addWeatherObjects:self.selectedItems];
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     if (followSegue) {
                                         [self.parentController performSegueWithIdentifier:kDetailSegue
                                                                                    sender:[CoreDataManager weatherZoneForZip:self.selectedItems.firstObject]];
                                     }
                                 }];
    }
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:CellIdentifier];
    }
    NSString * wz = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = wz;
    return cell;
}

-(void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * wz = [self.dataSource objectAtIndex:indexPath.row];
    [self.selectedItems addObject:wz];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * wz = [self.dataSource objectAtIndex:indexPath.row];
    [self.selectedItems removeObject:wz];
}


@end
