//
//  LoginController.h
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/2/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIController.h"
#import "User.h"

@protocol LoginControllerDelegate<NSObject>

@optional
-(void) didRequestLogin: (User *)user taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
@end
@interface LoginController : NSObject
{
    id multicastDelegate;
}
-(NSURLSessionDataTask *) postLoginWithEmail: (NSString *) email password: (NSString *) password;
@property (nonatomic) APIController *connection;
- (void)addDelegate:(id)delegate;
+(id) getInstance;

@end
