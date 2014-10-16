//
//  PhotosViewController.m
//  InstagramClient
//
//  Created by Kent Tam on 10/15/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoTableViewCell.h"
#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController ()
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 320;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"PhotoCell"];
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?access_token=226783985.7042340.02630687e306405cb87ebcf2afab28a9"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.photos = responseDictionary[@"data"];
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoDetailsViewController *vc = [[PhotoDetailsViewController alloc]init];
    vc.photo = self.photos[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    NSDictionary *photo = self.photos[indexPath.row];
    
    NSString *imageUrl = [photo valueForKeyPath:@"images.standard_resolution.url"];
    [cell.igImageView setImageWithURL: [NSURL URLWithString:imageUrl]];
    return cell;
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?access_token=226783985.7042340.02630687e306405cb87ebcf2afab28a9"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       self.photos = responseDictionary[@"data"];
       [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
