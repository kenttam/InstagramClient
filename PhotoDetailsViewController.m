//
//  PhotoDetailsViewController.m
//  
//
//  Created by Kent Tam on 10/15/14.
//
//

#import "PhotoDetailsViewController.h"
#import "PhotoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()
@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 320;
    [self.tableView registerNib:[UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"PhotoCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    
    NSString *imageUrl = [self.photo valueForKeyPath:@"images.standard_resolution.url"];
    [cell.igImageView setImageWithURL: [NSURL URLWithString:imageUrl]];
    return cell;
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
