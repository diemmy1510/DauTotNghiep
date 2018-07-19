//
//  DataManager.h
//  DauTotNghiep
//
//  Created by test on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "APIController.h"
@interface DataManager : NSObject
{
   id multicastDelegate; 
}
@property(nonatomic, strong) User *currentUserLogin;
@property (nonatomic, strong) NSDate *setTimeUpdate;
+(instancetype) sharedInstance;
-(void)insertSubjects : (NSArray *)arrObject;
-(void) insertTest:(NSArray *)arrObject;
-(NSString *)pathpdfFile;
-(void) deleteAllDeThi;
-(void) deleteAllMonHoc;
-(NSArray *)getListDeThiMonTheoID:(NSString *)idMon;
-(NSArray *)getListDeTOP;
-(NSArray *)getListDeFromArrMonHoctheoID: (NSArray *)arr withArrColumnNames : (NSArray *)arrColumnNames;
- (NSString *)pdfPath;

-(NSArray *)getAllSubjects;
-(NSArray *)searchListDe :(NSString *)searchText;
-(NSArray *)getArrTests;
@end
