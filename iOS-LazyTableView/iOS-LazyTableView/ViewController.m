//
//  ViewController.m
//  iOS-LazyTableView
//
//  Created by Domenico Vacchiano on 15/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "ViewController.h"
#define LAZY_LOAD_PAGE_SIZE 15
@interface ViewController ()
@property (weak, nonatomic) IBOutlet L3SDKLazyTableView *lazyTableView;
@property (nonatomic,strong)NSMutableArray*dataSource;
@property (weak, nonatomic) IBOutlet UILabel *itemsIndicator;

-(void)fetchNewItems;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //data source initialization
    self.dataSource=[[NSMutableArray alloc] initWithCapacity:LAZY_LOAD_PAGE_SIZE];
    [self fetchNewItems];
    //Lazy Table View initialization
    self.lazyTableView.delegate=self;
    self.lazyTableView.dataSource=self;
    self.lazyTableView.lazyLoadEnabled=YES;
    self.lazyTableView.lazyLoadPageSize=LAZY_LOAD_PAGE_SIZE;
   
}
-(void)fetchNewItems{
    
    //add items to datasource
    NSUInteger count=self.dataSource.count;
    for (int i=0; i<LAZY_LOAD_PAGE_SIZE; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"Item - %lu", count+1]];
        count++;
    }
    //set label text
    self.itemsIndicator.text=[NSString stringWithFormat:@"%lu items loaded.",(unsigned long)count];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- LazyLoad Table View

- (void)tableView:(UITableView *)tableView lazyLoadNextCursor:(int)cursor{
    //for instance here you can execute webservice request lo load more data
    [self fetchNewItems];
    [self.lazyTableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text=[self.dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




@end
