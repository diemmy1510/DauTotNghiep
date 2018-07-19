//
//  APIController.m
//  HotGift
//
//  Created by BaoPham on 11/23/2016.
//  Copyright © 2016 BaoPham. All rights reserved.
//

#import "APIController.h"
#import "AFNetworking.h"
#import "Def.h"
#import "MulticastDelegate.h"

@interface APIController()

@property (nonatomic, strong) AFHTTPSessionManager *connectionManager;

@end


@implementation APIController

+ (instancetype) shareInstance
{
    static APIController *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      _shareInstance = [[self alloc] initBaseURL: BaseURL];
                  });
    
    return _shareInstance;
}

- (id) initBaseURL: (NSString *) baseUrl
{
    if (self = [super init])
    {
        self.connectionManager = [[AFHTTPSessionManager manager] initWithBaseURL: [NSURL URLWithString: baseUrl]];
        //        self.connectionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        //        self.connectionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        multicastDelegate = [[MulticastDelegate alloc] init];
    }
    
    return self;
}

- (void) addDelegate: (id) delegate
{
    [multicastDelegate addDelegate: delegate];
}

- (NSURLSessionDownloadTask *)downloadFile:(NSString *)dowloadUrlLink pathStore:(NSString *)pathStore
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL =   [NSURL URLWithString:dowloadUrlLink relativeToURL:self.connectionManager.baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *directoryURL = [NSURL fileURLWithPath:pathStore isDirectory:YES];
        [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *fileNameOutput = [response suggestedFilename];
        
        return [directoryURL URLByAppendingPathComponent:fileNameOutput];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if(multicastDelegate && [multicastDelegate respondsToSelector:@selector(didDownloadfile:taskRequest:error:errorObject:)])
        {
            [multicastDelegate didDownloadfile:filePath taskRequest:nil error:error errorObject:nil];
        }
        
    }];
    [downloadTask resume];
    return downloadTask;
}

- (NSURLSessionDataTask *) requestAPI: (NSString *) apiName
                               method: (REQUEST_METHOD) method
                           parameters: (NSDictionary *) parameters
                              success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *paras = [[NSMutableDictionary alloc] initWithDictionary: parameters];
    NSURLSessionDataTask *task = nil;
    if(self.accessToken)
    {
        [self.connectionManager.requestSerializer setValue:self.accessToken forHTTPHeaderField:@"access-token"];
    }
    switch (method)
    {
        case POST_METHOD:
        {
            task = [self.connectionManager POST: apiName
                                     parameters: parameters
                                       progress: nil
                                        success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                success(task, responseObject);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector: @selector(receiveMessage:responseObject:)])
                {
                    [multicastDelegate receiveMessage: task responseObject: responseObject];
                }
            }
                                        failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                failure(task, error);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector: @selector(receiveMessageFailure:error:)])
                {
                    [multicastDelegate receiveMessageFailure: task error: error];
                }
            }];
        }
            break;
            
        case GET_METHOD:
        {
            task = [self.connectionManager GET: apiName
                                    parameters: parameters
                                      progress: nil
                                       success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                success(task, responseObject);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector: @selector(receiveMessage:responseObject:)])
                {
                    [multicastDelegate receiveMessage: task responseObject: responseObject];
                }
            }
                                       failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                failure(task, error);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(receiveMessageFailure:error:)])
                {
                    [multicastDelegate receiveMessageFailure: task error: error];
                }
            }];
        }
            break;
            
        case DELETE_METHOD:
        {
            task = [self.connectionManager DELETE: apiName
                                       parameters: paras
                                          success: ^(NSURLSessionDataTask *task, id responseObject)
            {
                success(task, responseObject);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(receiveMessage:responseObject:)])
                {
                    [multicastDelegate receiveMessage: task responseObject: responseObject];
                }
            }
                                          failure: ^(NSURLSessionDataTask *task, NSError *error)
            {
                failure(task, error);
                
                if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(receiveMessageFailure:error:)])
                {
                    [multicastDelegate receiveMessageFailure: task error: error];
                }
            }];
            
        }
            break;
            
        default:
            break;
    }
    
    return task;
}
-(NSURLSessionDataTask *)getTimeUpdate{
    NSURLSessionDataTask *requestTask = [[APIController shareInstance] requestAPI:APItimeupdate
                                                                           method: GET_METHOD
                                                                       parameters: nil
                                                                          success: ^(NSURLSessionDataTask *task, id responseObject)
                                         {
                                             
                                             int resultCode = [[responseObject objectForKey:kResultCodeKeyName]intValue];
                                             
                                             if (resultCode == kRequestOK && multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestTimeUpdate:taskRequest:error:errorObject:)]) {
                                                 NSDate *timeUpdate = [responseObject objectForKey:last_update];
                                                 
                                                 [multicastDelegate didRequestTimeUpdate:timeUpdate taskRequest:task error:nil errorObject:nil];
                                             }
                                             else if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestTimeUpdate:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestTimeUpdate:nil taskRequest:task error:nil errorObject:responseObject];
                                             }
                                             
                                         }
                                                                          failure:^(NSURLSessionDataTask *task, NSError *error)
                                         {
                                             if (multicastDelegate && [multicastDelegate respondsToSelector:@selector(didRequestTimeUpdate:taskRequest:error:errorObject:)])
                                             {
                                                 [multicastDelegate didRequestTimeUpdate:nil taskRequest:task error:nil errorObject:nil];
                                             }
                                         }];
    
    return requestTask;
}

@end
