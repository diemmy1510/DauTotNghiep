//
//  DeThiController.m
//  DauTotNghiep
//
//  Created by test on 2/22/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "DeThiController.h"
#import "MulticastDelegate.h"
#import "Def.h"
#import "De.h"
@implementation DeThiController
+(id) getInstance{
    static DeThiController *getInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        getInstance = [[self alloc] initConnection];
    });
    return getInstance;
}
- (id) initConnection
{
    if(self = [super init])
    {
        multicastDelegate = [[MulticastDelegate alloc] init];
        self.connection = [APIController shareInstance];
    }
    
    return self;
}
- (void)addDelegate:(id)delegate
{
    [multicastDelegate addDelegate:delegate];
}
-(NSURLSessionDataTask *)getTest
{
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APIGeTest
                                                                           method: GET_METHOD
                                                                       parameters: nil
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                             
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                             
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListTests:taskRequest:error:errorObject:)]) {
                                                 NSMutableArray *arr = [NSMutableArray new];
                                                 NSArray *arrJson = [responseObject objectForKey:kListMonHon];
                                                 for(id item in arrJson)
                                                 {
                                                     De *deThi = [[De alloc] initWithJson:item];
                                                     [arr addObject:deThi];
                                                 }
                                                 [multicastDelegate didRequestListTests:arr taskRequest:task error:nil errorObject:nil];
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListTests:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestListTests:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                             
                                             
                                             
                                         }
                                                                          failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListTests:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestListTests:nil taskRequest:task error:error errorObject:nil];
                                             }
                                         }];
    
    return requestTask;
}


@end
