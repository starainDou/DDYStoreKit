

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
#import "DDYStoreProductViewController.h"

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif

#ifndef DDYScreenW
#define DDYScreenW [UIScreen mainScreen].bounds.size.width
#endif

#ifndef DDYScreenH
#define DDYScreenH [UIScreen mainScreen].bounds.size.height
#endif

@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:[self btnY: 50 tag:100 title:@"App Store In App All"]];
    [self.view addSubview:[self btnY:100 tag:101 title:@"App Store In App Half"]];
    [self.view addSubview:[self btnY:150 tag:102 title:@"Review In App Store"]];
    [self.view addSubview:[self btnY:200 tag:103 title:@"Review In App"]];
    [self.view addSubview:[self btnY:250 tag:104 title:@"Test AlertVC"]];
    [self.view addSubview:[self btnY:300 tag:105 title:@"-"]];
    [self.view addSubview:[self btnY:350 tag:106 title:@"-"]];
}

- (UIButton *)btnY:(CGFloat)y tag:(NSUInteger)tag title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setFrame:CGRectMake(10, DDYTopH + y, DDYScreenW-20, 40)];
    [button setTag:tag];
    [button addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)handleBtn:(UIButton *)sender {
    
    if (sender.tag == 100) {
        [self showAppStoreInAppAllWithAppID:@"444934666"];
    } else if (sender.tag == 101) {
        [self showAppStoreInAppHalfWithAppID:@"444934666"];
    } else if (sender.tag == 102) {
        [self reviewInAppStore:@"444934666"];
    } else if (sender.tag == 103) {
        [self reviewInApp];
    } else if (sender.tag == 104) {
        
    } else if (sender.tag == 105) {
        
    } else if (sender.tag == 106) {
        
    }
}

- (void)showAppStoreInAppAllWithAppID:(NSString *)appID {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appID forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
        NSLog(@"result:%@ error:%@",result ? @"YES" : @"NO", error ? error : @"No Error");
    }];
    [self presentViewController:storeProductVC animated:YES completion:nil];
}

- (void)showAppStoreInAppHalfWithAppID:(NSString *)appID {
    DDYStoreProductViewController *vc = [[DDYStoreProductViewController alloc] init];
    vc.appID = appID;
    [self presentViewController:vc animated:YES completion:^{ }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"productViewControllerDidFinish");
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark APP评分姿势1
- (void)reviewInAppStore:(NSString *)appID {
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma mark APP评分姿势2 10.3+
- (void)reviewInApp {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        NSLog(@"只支持iOS 10.3+，定制化差，同一个ID一年只能三次弹窗");
    }
}


@end

// SKStoreProductParameterITunesItemIdentifier
// 希望展示App的AppID，该Key所关联的值是一个NSNumber类型。支持iOS6以后的系统版本。

// SKStoreProductParameterAffiliateToken
// 附属令牌，该Key所关联的值是NSString类型。例如在iBook中app的ID,是iOS8中新添加的，支持iOS8以后的系统版本。

// SKStoreProductParameterCampaignToken
// 混合令牌，该Key所关联的值是一个40byte的NSString类型，使用这个令牌，你能看到点击和销售的数据报告。支持iOS8以后的系统版本。

// SKStoreProductParameterProviderToken
// 该Key所关联的值是NSString类型  分析提供者令牌(NSString) 8.3

// SKStoreProductParameterAdvertisingPartnerToken
// 该Key所关联的值是NSString类型  广告合作伙伴令牌(NSString) 9.3
