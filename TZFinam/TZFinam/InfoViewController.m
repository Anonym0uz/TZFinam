//
//  InfoViewController.m
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "InfoViewController.h"
#import "UIMaker.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIMaker setupNavigationController:self.navigationController andTitle:@"Info" andItem:self.navigationItem withLeftBtn:nil andRightBtn:nil];
    [self createViewElements];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
}

@end
