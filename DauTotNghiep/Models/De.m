//
//  De.m
//  DauTotNghiep
//
//  Created by 507-3 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "De.h"

#define kKeyIsFavorite @"FV"
@implementation De
-(id) initWithJson: (id)json{
    if (self = [super init]) {
        self.maDe = [[json objectForKey:ma_de] integerValue];
        self.tenDe = [json objectForKey:ten_de];
        self.noiDung = [json objectForKey:noi_dung];
        self.linkDownload = [json objectForKey:link_download];
        self.createDate = [json objectForKey:create_date];
        self.lastUpdate = [json objectForKey:last_update];
        self.maMon = [json objectForKey:ma_mon];
        self.tagSearch = [json objectForKey:tag_search];
        self.imageDe = [json objectForKey:image_thumb];
        self.linkDapAn = [json objectForKey:link_dapan];
    }
    return self;
}
- (NSString *)keyDe
{
    return [NSString stringWithFormat:@"%@_%@",kKeyIsFavorite,[NSString stringWithFormat:@"%ld",self.maDe]];
}
- (BOOL)isFavorite
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if(![userDefault objectForKey:[self keyDe]])
    {
        return false;
    }
    return [userDefault boolForKey:[self keyDe]];
}
- (void)setIsFavorite:(BOOL)isFavorite
{
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isFavorite forKey:[self keyDe]];
    [userDefault synchronize];
}
@end
