//
//  DataManager.m
//  DauTotNghiep
//
//  Created by test on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "DataManager.h"
#import "MonHoc.h"
#import "MonHocController.h"
#import "De.h"
#import "DeThiController.h"
#import "MulticastDelegate.h"
#import "Def.h"
#import "SqliteEngineManager.h"
#import "Favorite.h"

@implementation DataManager
+(instancetype) sharedInstance{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t oneChoice;
    dispatch_once(&oneChoice , ^{sharedInstance = [[DataManager alloc]init];
    });
    
    return sharedInstance;
}


- (void) addDelegate: (id) delegate
{
    [multicastDelegate addDelegate: delegate];
}
-(id) init
{
    if (self = [super init]) {
        multicastDelegate = [[MulticastDelegate alloc] init];
        [[MonHocController getInstance] addDelegate:self];
        
    }
    return self;
}

-(void)insertSubjects : (NSArray *)arrObject
{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    for (MonHoc *monHoc in arrObject) {
        NSString *sql =  [NSString stringWithFormat:@"insert into TblMonHoc(maMonHoc, tenMonHoc, createDate,imageMon,lastUpdate,position_index) values('%@','%@','%@','%@','%@', '%ld')",monHoc.maMon, monHoc.tenMon, monHoc.createDate, monHoc.imageMon, monHoc.lastUpdate, (unsigned long)monHoc.positionIndex];
        [engine executeQuery:sql];
    }
}
-(NSArray *)getAllSubjects
{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *sql =[NSString stringWithFormat:@"select  tenMonHoc, maMonHoc, imageMon, createDate, lastUpdate, position_index from tblMonHoc "];
    NSArray*arr = [engine loadDataFromDB:sql];
    return [self getListMonHocFromSQlite:arr withArrColumnNames:engine.arrColumnNames];
}

-(NSArray *)getListMonHocFromSQlite: (NSArray *)arr withArrColumnNames : (NSArray *)arrColumnNames{
    NSMutableArray *arrAllSubjects = [NSMutableArray new];
    
    for (NSArray *item in arr) {
        NSInteger indexmaMonHoc =[arrColumnNames indexOfObject:@"maMonHoc"];
        NSString* maMonHoc= [item objectAtIndex:indexmaMonHoc];
        NSInteger indextenMonHoc =[arrColumnNames indexOfObject:@"tenMonHoc"];
        NSString *tenMonHoc=[item objectAtIndex:indextenMonHoc];
        NSInteger indeximageMon=[arrColumnNames indexOfObject:@"imageMon"];
        NSString *imageMon=[item objectAtIndex:indeximageMon];
        NSInteger indexcreateDate =[arrColumnNames indexOfObject:@"createDate"];
        NSDate *createDate=[item objectAtIndex:indexcreateDate];
        NSInteger indexlastUpdate=[arrColumnNames indexOfObject:@"lastUpdate"];
        NSDate *lastUpdate=[item objectAtIndex:indexlastUpdate];
        NSInteger indexpositiion_index=[arrColumnNames indexOfObject:@"position_index"];
        NSInteger positionindex = [[item objectAtIndex:indexpositiion_index] integerValue];
        
        MonHoc *monHoc = [MonHoc new];
        monHoc.maMon = maMonHoc;
        monHoc.tenMon = tenMonHoc;
        monHoc.createDate = createDate;
        monHoc.lastUpdate = lastUpdate;
        monHoc.imageMon = imageMon;
        monHoc.positionIndex = positionindex;
        [arrAllSubjects addObject:monHoc];
    }
    return arrAllSubjects;

}
-(void) insertTest:(NSArray *)arrObject {
    
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    for (De *de in arrObject) {
        NSString *sql =  [NSString stringWithFormat:@"insert into TblDe(tenDe, maDe, noiDung, linkDownload ,createDate ,lastUpdate, maMon, tagSearch, imageDe, linkDapAn) values('%@','%ld','%@','%@','%@', '%@', '%@','%@', '%@', '%@' )",de.tenDe, de.maDe, de.noiDung, de.linkDownload, de.createDate, de.lastUpdate, de.maMon, de.tagSearch, de.imageDe, de.linkDapAn];
        [engine executeQuery:sql];
    }
}
-(void)insertFavorite:(NSArray *)arrObject
{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    for (Favorite *favor in arrObject) {
        NSString *sql =  [NSString stringWithFormat:@"insert into TblFavorite(maDe, createDate, createTimer) values('%ld','%@','%@')", favor.maDe, favor.createDate, favor.createTimer];
        [engine executeQuery:sql];
    }

}
-(void) deleteAllDeThi{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *sql = @"delete from TblDe";
    [engine executeQuery:sql];
}
-(void) deleteAllMonHoc{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *sql = @"delete from TblMonHoc";
    [engine executeQuery:sql];
}

-(NSArray *)getListDeTOP
{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *sql =[NSString stringWithFormat:@"select  tenDe,maDe,maMon,imageDe,noiDung, linkDownload, createDate, lastUpdate , tagSearch , linkDapAn from tblDE Order By lastUpdate DESC LIMIT 9"];
    NSArray*arr= [engine loadDataFromDB:sql];
    return [self getListDeFromArrMonHoctheoID:arr withArrColumnNames:engine.arrColumnNames];
}

-(NSArray *)getListDeThiMonTheoID:(NSString *)idMon
{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *sql =[NSString stringWithFormat:@"select tenDe,maDe,maMon,imageDe,noiDung, linkDownload, createDate, lastUpdate , tagSearch , linkDapAn from tblDe where maMon ='%@'",idMon];
    NSArray*arr= [engine loadDataFromDB:sql];
    return [self getListDeFromArrMonHoctheoID:arr withArrColumnNames:engine.arrColumnNames];
    
    
}
-(NSArray *)getListDeFromArrMonHoctheoID: (NSArray *)arr withArrColumnNames : (NSArray *)arrColumnNames{
    NSMutableArray *arrResult = [NSMutableArray new];
    for(NSArray *item in arr){
        NSInteger indexmaDe =[arrColumnNames indexOfObject:@"maDe"];
        NSInteger maDe= [[item objectAtIndex:indexmaDe]integerValue];
        NSInteger indextenDe =[arrColumnNames indexOfObject:@"tenDe"];
        NSString *tenDe=[item objectAtIndex:indextenDe];
        NSInteger indexmaMon =[arrColumnNames indexOfObject:@"maMon"];
        NSString *maMon=[item objectAtIndex:indexmaMon];
        NSInteger indeximageDe=[arrColumnNames indexOfObject:@"imageDe"];
        NSString *imageDe=[item objectAtIndex:indeximageDe];
        
        NSInteger indexnoiDung=[arrColumnNames indexOfObject:@"noiDung"];
        NSString *noiDung=[item objectAtIndex:indexnoiDung];
        
        NSInteger indexlinkDownload=[arrColumnNames indexOfObject:@"linkDownload"];
        NSString *linkDownload=[item objectAtIndex:indexlinkDownload];
        
        NSInteger indexcreateDate=[arrColumnNames indexOfObject:@"createDate"];
        NSDate *createDate=[item objectAtIndex:indexcreateDate];
        
        NSInteger indexlastUpdate=[arrColumnNames indexOfObject:@"lastUpdate"];
        NSDate *lastUpdate=[item objectAtIndex:indexlastUpdate];
        
        NSInteger indextagSearch=[arrColumnNames indexOfObject:@"tagSearch"];
        NSString *tagSearch=[item objectAtIndex:indextagSearch];
        
        NSInteger indexlinkDapAn=[arrColumnNames indexOfObject:@"linkDapAn"];
        NSString *linkDapAn=[item objectAtIndex:indexlinkDapAn];

        De *deItem = [[De alloc] init];
        deItem.maDe = maDe;
        deItem.tenDe =tenDe;
        deItem.maMon = maMon;
        deItem.imageDe = imageDe;
        deItem.noiDung = noiDung;
        deItem.linkDownload = linkDownload;
        deItem.createDate = createDate;
        deItem.lastUpdate = lastUpdate;
        deItem.tagSearch = tagSearch;
        deItem.linkDapAn = linkDapAn;
        [arrResult addObject:deItem];
    }
    return arrResult;
}

-(NSString *)pathpdfFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* rootPath = paths[0];
    return [NSString stringWithFormat:@"%@/pdffile/",rootPath];
}

// Danh sach de thi yeu thich

-(NSArray *)getListDeThiFavorite: (NSArray *)arr withArrColumnNames : (NSArray *)arrColumnNames{

    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];

    NSString *sql =[NSString stringWithFormat:@"SELECT TblDe.tenDe,TblDe.maDe,TblFavorite.maDe,TblDe.noiDung,TblDe.linkDownload,TblDe.createDate,TblFavorite.createDate,TblDe.lastUpdate,TblDe.maMon,TblDe.tagSearch,TblDe.imageDe  FROM TblDe,TblFavorite where TblDe.maDe=TblFavorite.maDe"];
    
    arr= [engine loadDataFromDB:sql];

    return [self getListDeFromArrMonHoctheoID:arr withArrColumnNames:engine.arrColumnNames];
}
- (NSString *)pdfPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* rootPath = paths[0];
    //store file to library
    return [NSString stringWithFormat:@"%@/pdfpath/",rootPath];
}
//search
-(NSArray *)searchListDe :(NSString *)searchText{
    SqliteEngineManager *engine = [[SqliteEngineManager alloc] initWithDatabaseFilename:kDatabaseNameSQLite];
    NSString *ch = @"%";
    NSString *sql =[NSString stringWithFormat:@"select tenDe,maDe,noiDung,linkDownload,createDate,lastUpdate,tagSearch,maMon,imageDe,linkDapAn from TblDe Where tagSearch like '%@%@%@' ",ch,searchText,ch];
    
    NSArray*arr= [engine loadDataFromDB:sql];
    return [self getListDeFromArrMonHoctheoID:arr withArrColumnNames:engine.arrColumnNames];
}

-(NSArray *)getArrTests{
    [[DeThiController getInstance] getTest];
    return  nil;
}

@end




