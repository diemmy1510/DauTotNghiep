//
//  ListDeViewController.h
//  DauTotNghiep
//
//  Created by BaoPQ4 on 2/21/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonHoc.h"
#import "ReaderViewController.h"
typedef NS_ENUM(NSUInteger, ViewTarget) {
    ViewTargetNone =0,
    ViewTargetNoneMon,
    ViewTargetNoneSearch,
    ViewTargetNoneFavorite,
    ViewTargetNonhome
};
@interface ListDeViewController : UIViewController
{
}

@property (strong, nonatomic)  MonHoc *monHoc;
@property (nonatomic) ViewTarget viewTarget;
@property (weak, nonatomic) IBOutlet UITableView *listDeTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;
-(void)dismissReaderViewController:(ReaderViewController *)viewController;
@end
