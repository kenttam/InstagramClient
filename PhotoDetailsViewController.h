//
//  PhotoDetailsViewController.h
//  
//
//  Created by Kent Tam on 10/15/14.
//
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *photo;
@end
