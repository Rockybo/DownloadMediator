//
//  ViewController.m
//  DownloadMediator
//
//  Created by bolin on 2018/3/12.
//  Copyright © 2018年 bolin. All rights reserved.
//

#import "ViewController.h"
#import "Mediator+extension.h"

@interface ViewController ()
@property (nonatomic, strong) NSURL *url;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"];
    
}


- (IBAction)startDowloadAction:(UIButton *)sender {
    
    __weak typeof (self) weakSelf = self;
    [[Mediator sharedInstance] downLoader:self.url downloadInfo:^(id fileInfoItem) {
        
    } progress:^(CGFloat progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
    } state:^(NSUInteger state) {
        
    } success:^(NSString *filePath) {
        
    } failed:^{
        
    }];
    
}

- (IBAction)pauseDowloadAction:(UIButton *)sender {
    
    [[Mediator sharedInstance] pauseDownloadWithURL:self.url];
}
@end
