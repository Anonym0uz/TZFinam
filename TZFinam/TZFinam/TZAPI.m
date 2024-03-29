//
//  TZAPI.m
//  TZFinam
//
//  Created by Alexander Orlov on 06.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "TZAPI.h"
#import "Articles.h"

@implementation TZAPI

+ (TZAPI *)shared {
    static TZAPI *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[TZAPI alloc] init];
    });
    return _shared;
}

- (void)getNewsfeedByURL:(TZAPIType)type handler:(void(^)(BOOL success, NSString *error, id response))complete {
    
    NSURL *url = [NSURL URLWithString:@""];
    
    switch (type) {
        case TZAPITypeBitcoin:
            url = [self setBitRequest];
            break;
        case TZAPITypeBusiness:
            url = [NSURL URLWithString:@"https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3d41bfba49f947c386feef461c8b1b55"];
            break;
        case TZAPITypeMenthApple:
            url = [self setMenthAppleRequest];
            break;
        case TZAPITypeFromTechCrunchCorp:
            url = [NSURL URLWithString:@"https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3d41bfba49f947c386feef461c8b1b55"];
            break;
        case TZAPITypeByWallStreet:
            url = [NSURL URLWithString:@"https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3d41bfba49f947c386feef461c8b1b55"];
            break;
        default:
            break;
    }
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@", url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          NSError *err;
          NSDictionary *artJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
          if (err){
              NSLog(@"Failed parse JSON: %@", err);
              complete(false, [NSString stringWithFormat:@"%@", err], nil);
              return;
          }
          
          NSMutableArray<Articles *> *articles = NSMutableArray.new;
          for (NSDictionary *artDict in [artJSON objectForKey:@"articles"]) {
              Articles *article = Articles.new;
              Source *source = Source.new;
              NSDictionary *sourceDict = artDict[@"source"];
              article.author = artDict[@"author"];
              article.title = artDict[@"title"];
              article.descript = artDict[@"description"];
              article.url = artDict[@"url"];
              article.urlToImage = artDict[@"urlToImage"];
              article.publDate = artDict[@"publishedAt"];
              article.content = artDict[@"content"];
              source.name = sourceDict[@"name"];
              source.ids = sourceDict[@"id"];
              article.source = source;
              [articles addObject:article];
          }
          complete(true, @"", articles);
      }] resume];
}

- (NSURL *)setBitRequest {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *urlStr = [NSString stringWithFormat:@"https://newsapi.org/v2/everything?q=bitcoin&from=%@&sortBy=publishedAt&apiKey=3d41bfba49f947c386feef461c8b1b55", [dateFormatter stringFromDate:[NSDate date]]];
    return [NSURL URLWithString:urlStr];
}

- (NSURL *)setMenthAppleRequest {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *urlStr = [NSString stringWithFormat:@"https://newsapi.org/v2/everything?q=apple&from=%@&to=%@&sortBy=popularity&apiKey=3d41bfba49f947c386feef461c8b1b55", [dateFormatter stringFromDate:[NSDate date]], [dateFormatter stringFromDate:[NSDate date]]];
    return [NSURL URLWithString:urlStr];
}

@end
