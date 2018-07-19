//
//  MonHocController.m
//  DauTotNghiep
//
//  Created by test on 2/22/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "MonHocController.h"
#import "MulticastDelegate.h"
#import "Def.h"
#import "APIController.h"
#import "MonHoc.h"
@interface MonHocController (){
  
}
@end

@implementation MonHocController
+(id) getInstance{
    static MonHocController *getInstance = nil;
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
-(NSURLSessionDataTask *)getSubjects{
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APIGetSubject
                                                                           method: GET_METHOD
                                                                       parameters: nil
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                          
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                       
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListSubjects:taskRequest:error:errorObject:)]) {
                                                 NSMutableArray *arr = [NSMutableArray new];
                                                 NSArray *arrJson = [responseObject objectForKey:kListMonHon];
                                                 for(id item in arrJson)
                                                 {
                                                     MonHoc *monhoc = [[MonHoc alloc] initWithJson:item];
                                                     [arr addObject:monhoc];
                                                 }
                                                 [multicastDelegate didRequestListSubjects:arr taskRequest:task error:nil errorObject:nil];
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListSubjects:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestListSubjects:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                             
                                             
                                             
                                         }
                                        failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestListSubjects:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestListSubjects:nil taskRequest:task error:error errorObject:nil];
                                             }
                                             

                                         }];
    
    return requestTask;

}
@end
