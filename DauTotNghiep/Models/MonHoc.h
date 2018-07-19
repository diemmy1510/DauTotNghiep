//
//  MonHoc.h
//  DauTotNghiep
//
//  Created by 507-3 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Def.h"
@interface MonHoc : NSObject
@property (nonatomic,strong) NSDate *createDate;
@property (nonatomic,strong) NSDate *lastUpdate;
@property (nonatomic,strong)NSString *imageMon;
@property (nonatomic,strong) NSString *maMon;
@property (nonatomic, assign) NSUInteger positionIndex;
@property (nonatomic, strong) NSString *tenMon;

-(id)initWithcreateDate:(NSDate *)createDate image:(NSString*)image lastUpdate:(NSDate *)lastUpdate maMon: (NSString *)maMon positionIndex: (NSInteger )positionIndex tenMon:(NSString *)tenMon;
-(id)initWithJson:(id)json;
@end
