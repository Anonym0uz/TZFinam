//
//  UIMaker.h
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIMaker : NSObject

+ (void)setupNavigationController:(UINavigationController *)navContr andTitle:(NSString *)title andItem:(UINavigationItem *) navItem withLeftBtn:(UIBarButtonItem*)leftBtn andRightBtn:(UIBarButtonItem*)rightBtn;
+ (UIBarButtonItem *)setupBarButton:(NSString *)title image:(NSString *)imgString target:(id)target action:(SEL)action;
@end
