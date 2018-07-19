//
//  LoginController.m
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/2/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "LoginController.h"
#import "MulticastDelegate.h"
#import "Def.h"
#import "User.h"

@implementation LoginController

+(id) getInstance{
    static LoginController *getInstance = nil;
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
-(NSURLSessionDataTask *) postLoginWithEmail: (NSString *) email password: (NSString *) password;
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:email, kEmail, password, kPassword, nil];
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APIPostUser
                                                                           method: POST_METHOD
                                                                       parameters: dict
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestLogin:taskRequest:error:errorObject:)]) {
                                                 User *user  = [[User alloc] init];
                                                 user.fullName = [[responseObject objectForKey:@"userinfo"] objectForKey:kFullname];
                                                 [multicastDelegate didRequestLogin:user taskRequest:task error:nil errorObject:nil];
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestLogin:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestLogin:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                         }
                                                                          failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestLogin:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestLogin:nil taskRequest:task error:error errorObject:nil];
                                             }
                                         }];
    return requestTask;
}

@end
