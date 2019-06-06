//
//  TZAPI.h
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TZAPIType){
    TZAPITypeBitcoin = 0,
};

NS_ASSUME_NONNULL_BEGIN

// 3d41bfba49f947c386feef461c8b1b55

@interface TZAPI : NSObject
+ (TZAPI *)shared;

- (void)getNewsfeedByURL:(TZAPIType)type handler:(void(^)(BOOL success, NSString *error, id response))complete;
@end

NS_ASSUME_NONNULL_END
