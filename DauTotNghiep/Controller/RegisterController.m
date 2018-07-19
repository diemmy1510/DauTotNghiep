//
//  RegisterController.m
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/1/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "RegisterController.h"
#import "MulticastDelegate.h"
#import "Def.h"
#import "User.h"

@implementation RegisterController

+(id) getInstance{
    static RegisterController *getInstance = nil;
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
-(NSURLSessionDataTask *) postRegisterWithUser: (User *) user;
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.email, kEmail, user.password, kPassword, user.fullName, kFullname, user.birthday, kBirthday, user.address, kAddress, nil];
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APIPostRegister
                                                                           method: POST_METHOD
                                                                       parameters: dict
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestRegister:taskRequest:error:errorObject:)]) {
                                                 User *user  = [[User alloc] init];
                                                 user.fullName = [[responseObject objectForKey:@"userinfo"] objectForKey:kFullname];
                                                 [multicastDelegate didRequestRegister:user taskRequest:task error:nil errorObject:nil];
                                                 
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestRegister:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestRegister:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                         }
                                                                          failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestRegister:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestRegister:nil taskRequest:task error:error errorObject:nil];
                                             }
                                         }];
    return requestTask;
}
@end
