//
//  VCModel.m
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "VCModel.h"

@implementation VCModel
+ (VCModel *)sharedModel {
    static VCModel *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[VCModel alloc] init];
    });
    
    return _shared;
}

- (void)getDataFromAPIByURL:(TZAPIType)type completeHandler:(void(^)(BOOL success, NSString *error, id response))cHandl {
    [TZAPI.shared getNewsfeedByURL:type handler:^(BOOL success, NSString * _Nonnull error, id  _Nonnull response) {
        if (success) {
            cHandl(true, @"", response);
        } else {
            cHandl(false, error, nil);
        }
    }];
}
@end
