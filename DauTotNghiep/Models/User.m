//
//  User.m
//  DauTotNghiep
//
//  Created by Nguyễn Hưng on 3/3/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithEmail:(NSString *)email fullName:(NSString *)fullName password:(NSString *)password address: (NSString *)address birthday:(NSDate *)birthday{
    if (self = [super init]) {
        self.email = email;
        self.password = password;
        self.fullName = fullName;
        self.address = address;
        self.birthday = birthday;
    }
    return self;
}
@end
