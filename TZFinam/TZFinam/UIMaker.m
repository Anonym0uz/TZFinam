//
//  UIMaker.m
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "UIMaker.h"

@implementation UIMaker
+ (void)setupNavigationController:(UINavigationController *)navContr andTitle:(NSString *)title andItem:(UINavigationItem *) navItem withLeftBtn:(UIBarButtonItem*)leftBtn andRightBtn:(UIBarButtonItem*)rightBtn {
    navContr.navigationBar.hidden = NO;
    navItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTranslucent:NO];
    navItem.title = title;
    navContr.navigationBar.barTintColor = [UIColor whiteColor];
    navContr.navigationBar.tintColor = [UIColor blackColor];
    [navContr.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    navItem.leftBarButtonItem = leftBtn;
    navItem.rightBarButtonItem = rightBtn;
}

+ (UIBarButtonItem *)setupBarButton:(NSString *)title image:(NSString *)imgString target:(id)target action:(SEL)action {
    UIBarButtonItem *barItem = [UIBarButtonItem new];
    barItem.title = title;
    barItem.image = [UIImage imageNamed:imgString];
    barItem.target = target;
    barItem.action = action;
    return barItem;
}
@end
