//
//  De.h
//  DauTotNghiep
//
//  Created by 507-3 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Def.h"

@interface De : NSObject
@property (nonatomic, assign) NSInteger maDe;
@property (nonatomic, strong) NSString *tenDe;
@property (nonatomic, strong) NSString *noiDung;
@property (nonatomic, strong) NSString *linkDownload;
@property (nonatomic,strong) NSDate *createDate;
@property (nonatomic,strong) NSDate *lastUpdate;
@property (nonatomic,strong)NSString *imageDe;
@property (nonatomic,strong) NSString *maMon;
@property (nonatomic, strong) NSString *tagSearch;
@property (nonatomic, strong) NSString *linkDapAn;
@property (nonatomic, strong) NSTimer *createTimer;
@property (nonatomic) BOOL isFavorite;
-(id) initWithJson: (id)json;

@end
