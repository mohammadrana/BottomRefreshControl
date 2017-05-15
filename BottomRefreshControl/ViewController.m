//
//  ViewController.m
//  BottomRefreshControl
//
//  Created by Rana on 8/28/16.
//  Copyright © 2016 Rana. All rights reserved.
//

#import "TableViewCell.h"
#import "ViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 100.0;
    [refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControl;
}

- (void)pullToRefresh:(UIRefreshControl*) sender{
    NSLog(@"pullToRefresh");
    // Update network activity UI
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Do work off the main thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Simulate network traffic (sleep for 2 seconds)
        [NSThread sleepForTimeInterval:2];
        //Update data
        // Call complete on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update network activity UI
            NSLog(@"COMPLETE");
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            [sender endRefreshing];
        });
    });
}

/*
-(void)initializeRefreshControl
{
    UIActivityIndicatorView *indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 44)];
    [indicatorFooter setColor:[UIColor blackColor]];
    [indicatorFooter startAnimating];
    [self.tableView setTableFooterView:indicatorFooter];
}

-(void)refreshTableVeiwList
{
    // your refresh code goes here
    NSLog(@"pullToRefresh");
    // Update network activity UI
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Do work off the main thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Simulate network traffic (sleep for 2 seconds)
        [NSThread sleepForTimeInterval:1];
        //Update data
        // Call complete on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update network activity UI
            NSLog(@"COMPLETE");
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
        });
    });
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height)
    {
        [self refreshTableVeiwList];
    }
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell height
    return 95;
}

// If the tableView Cell is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableViewCell";
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.listText.text = @"TEST";
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
