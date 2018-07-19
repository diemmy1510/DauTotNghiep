//
//  User.h
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/3/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSDate *birthday;

-(id)initWithEmail:(NSString *)email fullName:(NSString *)fullName password:(NSString *)password address: (NSString *)address birthday:(NSDate *)birthday;

@end
