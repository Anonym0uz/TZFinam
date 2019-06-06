//
//  Articles.h
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Source : NSObject
@property (strong, nonatomic) NSString *ids;
@property (strong, nonatomic) NSString *name;
@end

@interface Articles : NSObject

@property (strong, nonatomic) Source *source;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *urlToImage;
@property (strong, nonatomic) NSString *publDate;
@property (strong, nonatomic) NSString *content;

@end

NS_ASSUME_NONNULL_END
