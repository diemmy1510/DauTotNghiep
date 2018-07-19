//
//  ListDeViewController.m
//  DauTotNghiep
//
//  Created by BaoPQ4 on 2/21/17.
//  Copyright © 2017 D002. All rights reserved.
//

#import "ListDeViewController.h"
#import "SWRevealViewController.h"
#import "BaseCellDeThi.h"
#import "De.h"
#import "MonHocController.h"
#import "APIController.h"
#import "DataManager.h"
#import <QuickLook/QuickLook.h>
#import "MBProgressHUD.h"
#import "ReaderViewController.h"
//#import "DetailsViewController.h"
@import GoogleMobileAds;
@import Firebase;

@interface ListDeViewController ()<UITableViewDataSource, UITableViewDelegate, BaseCellDeThiDelegate,ReaderViewControllerDelegate,UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet GADBannerView  *bannerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) UIDocumentInteractionController *controller;
@property (nonatomic,strong) NSURL *pathPdf;
@property(nonatomic) NSArray *arrDe;
@property(nonatomic) NSArray *arrLuu;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation ListDeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(loadData) name:@"load10DeTop" object:nil];
     self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    //anlytics
    self.title = @"AAAA";
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                     kFIRParameterItemName:self.title,
                                     kFIRParameterContentType:@"image"
                                     }];
    //admob
    self.bannerView.adUnitID = @"ca-app-pub-3858269241810873/9530725546";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    [self.listDeTableView registerNib:[UINib nibWithNibName:@"BaseCellDeThi" bundle:nil] forCellReuseIdentifier:@"BaseCell"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    if(self.viewTarget == ViewTargetNone)
    {
        self.viewTarget = ViewTargetNonhome;
    }
    self.title = self.monHoc.tenMon;
    [self loadData];
    
    [[APIController shareInstance] addDelegate:self];
    //search
    self.listDeTableView.tableHeaderView = self.searchBar;
    self.searchBar.delegate = self;
    _arrLuu = _arrDe;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(void) loadData{
    switch (self.viewTarget) {
        case ViewTargetNoneMon:
            self.arrDe = [[DataManager sharedInstance] getListDeThiMonTheoID:self.monHoc.maMon];
            [self.listDeTableView reloadData];
            
            break;
        case ViewTargetNoneSearch:
            self.arrDe = [[DataManager sharedInstance] getArrTests];
            break;
         case ViewTargetNoneFavorite:
            self.arrDe = [[DataManager sharedInstance] getListDeThiMonTheoID:self.monHoc.maMon];
            [self.listDeTableView reloadData];
           
            break;
        case ViewTargetNonhome:
            
            self.arrDe = [[DataManager sharedInstance] getListDeTOP];
            [self.listDeTableView reloadData];
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *basecell =@"BaseCell";
    BaseCellDeThi *cell = (BaseCellDeThi *)[tableView dequeueReusableCellWithIdentifier:basecell];
    if(cell == nil){
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"BaseCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    De *itemDe;
    itemDe = [self.arrDe objectAtIndex:indexPath.row];
    cell.de = itemDe;
    cell.delegate = self;

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.arrDe.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addDe:(De *)deThiFavor
{
    deThiFavor.isFavorite = !deThiFavor.isFavorite;
    [_listDeTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.hud.detailsLabel.text = @"Waitting...!";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    De *itemDe = [self.arrDe objectAtIndex:indexPath.row];
    [[APIController shareInstance] downloadFile:itemDe.linkDownload pathStore:[[DataManager sharedInstance] pdfPath]];

}

-(void) didDownloadfile: (NSURL *)fileStore taskRequest: (NSURLSessionDataTask *)taskRequest error: (NSError *)error errorObject: (id)errorObject
{
    self.pathPdf = fileStore;
    
    
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
    NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    
    NSString *filePath = [pdfs firstObject]; assert(filePath != nil);
    //

      ReaderDocument *document = [ReaderDocument withDocumentFilePath:fileStore.path password:nil];
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        [self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
    else // Log an error so that we know that something went wrong
    {
        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
    }

    
}
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    // Break the path into its components (filename and extension)

        //NSURL *URL = [[NSBundle mainBundle] URLForResource:@"da-anh-qg2015" withExtension:@"pdf"];

    
    return self.pathPdf;
}


 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  //   DetailsViewController *detailsView = segue.destinationViewController;
//     [detailsView setDataSource:self];
//     [detailsView setCurrentPreviewItemIndex:0];
     
 }
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        _isFiltered = FALSE;
    }
    else
    {
        self.arrDe =[[DataManager sharedInstance] searchListDe:text];
    }
    
    [self.listDeTableView reloadData];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    _arrDe=_arrLuu;
    [self.listDeTableView reloadData];
}


@end
