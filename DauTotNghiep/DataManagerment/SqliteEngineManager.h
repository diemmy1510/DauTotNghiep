//
//  SQLManagement.h
//  DauTotNghiep
//
//  Created by test on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteEngineManager : NSObject
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;
- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (NSArray *)loadDataFromDB:(NSString *)query;
- (void)executeQuery:(NSString *)query;
@end
