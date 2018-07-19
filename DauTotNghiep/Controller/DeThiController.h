//
//  DeThiController.h
//  DauTotNghiep
//
//  Created by test on 2/22/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIController.h"
@protocol DeThiControllerDelegate<NSObject>
@optional
-(void) didRequestListTests: (NSArray *)arrTests taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;

@end

@interface DeThiController : NSObject
{
    id multicastDelegate;
}
-(NSURLSessionDataTask *)getTest;
-(NSURLSessionDataTask *)getTimeUpdate;
@property (nonatomic) APIController *connection;

- (void)addDelegate:(id)delegate;
+(id) getInstance;
@end
