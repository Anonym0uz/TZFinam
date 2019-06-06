//
//  ViewController.m
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
#import "Articles.h"

@interface ViewController ()
@property NSMutableArray *articlesArray;
@end

@implementation ViewController

#pragma mark - VC Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIMaker setupNavigationController:self.navigationController andTitle:@"Feed" andItem:self.navigationItem withLeftBtn:nil andRightBtn:nil];
    [self createViewElements];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDatasFromModel];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)createViewElements {
    self.view.backgroundColor = UIColor.whiteColor;
    self.articlesArray = NSMutableArray.new;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.tableView registerClass:[TZFCell class] forCellReuseIdentifier:@"FinamCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    [self.refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.view addSubview:self.tableView];
    
    [self getDatasFromModel];
}

- (void)getDatasFromModel {
    [VCModel.sharedModel getDataFromAPIByURL:TZAPITypeBitcoin completeHandler:^(BOOL success, NSString *error, id response) {
        if (success) {
            self.articlesArray = [NSMutableArray arrayWithArray:response];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            });
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TZFinam" message:@"Failed to parse data! Try later." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
}

- (void)reloadDatas {
    [self getDatasFromModel];
}

#pragma mark - TBDelegate & DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TZFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FinamCell" forIndexPath:indexPath];
    Articles *articl = self.articlesArray[indexPath.row];
    cell.cellTitle.text = articl.title;
    cell.cellContent.text = articl.content;
    cell.sourceName.text = articl.source.name;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articlesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    Articles *articl = self.articlesArray[indexPath.row];
    SFSafariViewController *viewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:articl.url]];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end


@implementation TZFCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self createElements];
    return self;
}

- (void)createElements {
    self.backgroundColor = [UIColor whiteColor];
    self.cellTitle = [[UILabel alloc] init];
    self.cellTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.cellTitle.textColor = UIColor.blackColor;
    self.cellContent = [[UILabel alloc] init];
    self.cellContent.textColor = UIColor.lightGrayColor;
    self.cellContent.translatesAutoresizingMaskIntoConstraints = false;
    self.cellContent.numberOfLines = 2;
    
    self.sourceName = [[UILabel alloc] init];
    self.sourceName.translatesAutoresizingMaskIntoConstraints = false;
    self.sourceName.textColor = UIColor.lightGrayColor;
    self.sourceName.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:self.cellTitle];
    [self.contentView addSubview:self.sourceName];
    [self.contentView addSubview:self.cellContent];
    
    [self.cellTitle.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:20].active = true;
    [self.cellTitle.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-20].active = true;
    [self.cellTitle.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20].active = true;
    
//    [self.sourceName.leftAnchor constraintEqualToAnchor:self.cellTitle.leftAnchor constant:20].active = true;
    [self.sourceName.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-20].active = true;
    [self.sourceName.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = true;
    
    [self.cellContent.topAnchor constraintEqualToAnchor:self.cellTitle.topAnchor constant:10].active = true;
    [self.cellContent.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-20].active = true;
    [self.cellContent.bottomAnchor constraintEqualToAnchor:self.sourceName.bottomAnchor constant:-2].active = true;
    [self.cellContent.leftAnchor constraintEqualToAnchor:self.cellTitle.leftAnchor].active = true;
}

@end
