//
//  ForgetPasswordController.m
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "ForgetPasswordController.h"
#import "MulticastDelegate.h"
#import "Def.h"

@implementation ForgetPasswordController
+(id) getInstance{
    static ForgetPasswordController *getInstance = nil;
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
-(NSURLSessionDataTask *) postForgetPassword: (NSString *) email;
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: email, kEmail, nil];
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APIPostForgetPassword
                                                                           method: POST_METHOD
                                                                       parameters: dict
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestForgetPassword:taskRequest:error:errorObject:)]) {
                                                 NSMutableArray *arr = [NSMutableArray new];
                                                 [multicastDelegate didRequestForgetPassword:arr taskRequest:task error:nil errorObject:nil];
                                                 
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestForgetPassword:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestForgetPassword:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                         }
                                                                          failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestForgetPassword:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestForgetPassword:nil taskRequest:task error:error errorObject:nil];
                                             }
                                         }];
    return requestTask;
}
@end
