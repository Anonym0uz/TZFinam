//
//  ViewController.h
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCModel.h"
#import "UIMaker.h"
#import <SafariServices/SFSafariViewController.h>

@interface TZFCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellImage;
@property (nonatomic, strong) UILabel *cellTitle;
@property (nonatomic, strong) UILabel *cellContent;
@property (nonatomic, strong) UILabel *sourceName;
@end

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property UITableView *tableView;
@property UIRefreshControl *refreshControl;

@end

