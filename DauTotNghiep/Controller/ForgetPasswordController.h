//
//  ForgetPasswordController.h
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/6/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIController.h"

@protocol RegisterControllerDelegate<NSObject>

@optional
-(void) didRequestForgetPassword: (NSArray *)arrRegister taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
@end
@interface ForgetPasswordController : NSObject
{
    id multicastDelegate;
}
-(NSURLSessionDataTask *) postForgetPassword: (NSString *) email;
@property (nonatomic) APIController *connection;
- (void)addDelegate:(id)delegate;
+(id) getInstance;
@end
