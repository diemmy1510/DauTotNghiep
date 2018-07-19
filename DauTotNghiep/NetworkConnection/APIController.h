//
//  APIController.h
//  HotGift
//
//  Created by BaoPham on 11/23/2016.
//  Copyright © 2016 BaoPham. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageControllerDelegate <NSObject>
@optional
- (void) receiveMessage: (NSURLSessionDataTask *) task responseObject: (id) responseObject;
- (void) receiveMessageFailure: (NSURLSessionDataTask *) task error: (NSError *) error;
-(void) didDownloadfile: (NSURL *)fileStore taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
-(void) didRequestTimeUpdate: (NSDate *)timeUpdate taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject;
@end

typedef enum
{
    POST_METHOD,
    GET_METHOD,
    PUT_METHOD,
    DELETE_METHOD
} REQUEST_METHOD;

@interface APIController : NSObject
{
    id multicastDelegate;
}

@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, strong) NSString *APIBaseURLString;
@property (nonatomic, strong) NSString *accessToken;
//@property (nonatomic, strong) NSDate *timeUpdate;

+ (APIController*) shareInstance;
- (void ) addDelegate: (id) delegate;

- (NSURLSessionDataTask *) requestAPI: (NSString *) apiName method: (REQUEST_METHOD) method parameters: (NSDictionary *) parameters
                              success: (void (^) (NSURLSessionDataTask *task, id responseObject))success
                              failure: (void (^) (NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDownloadTask *)downloadFile:(NSString *)dowloadUrlLink pathStore:(NSString *)pathStore;
-(NSURLSessionDataTask *)getTimeUpdate;

@end
