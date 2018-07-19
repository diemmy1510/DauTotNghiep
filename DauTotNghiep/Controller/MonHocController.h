//
//  MonHocController.h
//  DauTotNghiep
//
//  Created by test on 2/22/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIController.h"
@protocol MonHocControllerDelegate<NSObject>
@optional
-(void) didRequestListSubjects: (NSArray *)arrSubjects taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
@end

@interface MonHocController : NSObject
{
     id multicastDelegate;
}
+(id) getInstance;
-(NSURLSessionDataTask *)getSubjects;
@property (nonatomic) APIController *connection;
- (void)addDelegate:(id)delegate;
@end
