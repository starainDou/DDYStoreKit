
#import "DDYStoreProductViewController.h"
#import <StoreKit/StoreKit.h>

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif

#ifndef DDYScreenW
#define DDYScreenW [UIScreen mainScreen].bounds.size.width
#endif

#ifndef DDYScreenH
#define DDYScreenH [UIScreen mainScreen].bounds.size.height
#endif

@interface DDYStoreProductViewController ()<SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) SKStoreProductViewController *storeProductVC;

@end

@implementation DDYStoreProductViewController

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"我在顶部";
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.font = [UIFont boldSystemFontOfSize:30];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
        _topLabel.frame = CGRectMake(0, 0, DDYScreenW, 180);
    }
    return _topLabel;
}

- (SKStoreProductViewController *)storeProductVC {
    if (!_storeProductVC) {
        _storeProductVC = [[SKStoreProductViewController alloc] init];
        _storeProductVC.delegate = self;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:self.appID forKey:SKStoreProductParameterITunesItemIdentifier];
        [_storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
            NSLog(@"result:%@ error:%@",result ? @"YES" : @"NO", error ? error : @"No Error");
        }];
        _storeProductVC.view.frame = CGRectMake(0, 180, DDYScreenW, DDYScreenH-180);
    }
    return _storeProductVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.storeProductVC.view];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"productViewControllerDidFinish");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
