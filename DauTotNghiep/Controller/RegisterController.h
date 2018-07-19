//
//  RegisterController.h
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/1/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIController.h"
#import "User.h"

@protocol RegisterControllerDelegate<NSObject>

@optional
-(void) didRequestRegister: (User *)user taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
@end
@interface RegisterController : NSObject
{
    id multicastDelegate;
}
-(NSURLSessionDataTask *) postRegisterWithUser: (User *) user;
@property (nonatomic) APIController *connection;
- (void)addDelegate:(id)delegate;
+(id) getInstance;

@end
