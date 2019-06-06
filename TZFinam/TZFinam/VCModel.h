//
//  VCModel.h
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TZAPI.h"

@interface VCModel : NSObject
+ (VCModel *)sharedModel;
- (void)getDataFromAPIByURL:(TZAPIType)type completeHandler:(void(^)(BOOL success, NSString *error, id response))cHandl;
@end
