//
//  MonHoc.m
//  DauTotNghiep
//
//  Created by 507-3 on 2/20/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "MonHoc.h"

@implementation MonHoc

-(id)initWithJson:(id)json{
    if (self = [super init]) {
        self.createDate = [json objectForKey:create_date];
        self.imageMon = [json objectForKey:image_thumb];
        self.lastUpdate = [json objectForKey:last_update];
        self.maMon = [json objectForKey:ma_mon];
        self.positionIndex = [[json objectForKey:position_index] integerValue];
        self.tenMon = [json objectForKey:ten_mon];
    }
    return self;
}
@end
