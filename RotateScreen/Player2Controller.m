//
//  Player2Controller.m
//  RotateScreen
//
//  Created by bifangao on 16/7/12.
//  Copyright © 2016年 bifangao. All rights reserved.
//

#import "Player2Controller.h"

@interface Player2Controller ()
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *blueBtn;
@property (nonatomic, strong) UIButton *greenBtn;
@property (nonatomic, strong) UIButton *yellowBtn;
@end

@implementation Player2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0;
    [self customUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)customUserInterface{
    CGRect frame = self.view.frame;
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(frame), CGRectGetHeight(frame)/3)];
    playerView.backgroundColor = [UIColor grayColor];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(resizeScreen) forControlEvents:UIControlEventTouchUpInside];
    _redBtn = btn1;
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(playerView.frame) - 30, 0, 30, 30)];
    btn2.backgroundColor = [UIColor greenColor];
    _greenBtn = btn2;
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(playerView.frame) - 30, 30, 30)];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 addTarget:self action:@selector(showStatusBar) forControlEvents:UIControlEventTouchUpInside];
    _blueBtn = btn3;
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(playerView.frame) - 30, CGRectGetHeight(playerView.frame) - 30, 30, 30)];
    btn4.backgroundColor = [UIColor yellowColor];
    [btn4 addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
    _yellowBtn = btn4;
    
    [playerView addSubview:btn1];
    [playerView addSubview:btn2];
    [playerView addSubview:btn3];
    [playerView addSubview:btn4];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 80, 100, 100)];
    textField.placeholder = @"测试键盘弹出向";
    [playerView addSubview:textField];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
}

- (void)fullScreen{
    [UIView animateWithDuration:.5f animations:^{
        [self rotateWindow];
        
        
//        [self rotateDevice];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.alpha = 0;
        [self prefersStatusBarHidden];
        [UIView animateWithDuration:.25f animations:^{
            [self hideStatusBar];
        }];
    }];
    
}

- (void)rotateWindow{
    UIApplication *application=[UIApplication sharedApplication];
    application.keyWindow.transform=CGAffineTransformMakeRotation(M_PI/2);
    application.keyWindow.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [application setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
    _playerView.frame = self.view.bounds;
    _redBtn.frame = CGRectMake(0, 0, 30, 30);
    _greenBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, 0, 30, 30);
    _blueBtn.frame = CGRectMake(0, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
    _yellowBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, CGRectGetHeight(_playerView.frame) - 30, 30, 30);

//    application.keyWindow.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    [self preferredInterfaceOrientationForPresentation];
}

- (void)rotateDevice{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    _playerView.frame = self.view.bounds;
    _redBtn.frame = CGRectMake(0, 0, 30, 30);
    _greenBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, 0, 30, 30);
    _blueBtn.frame = CGRectMake(0, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
    _yellowBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
}

- (void)resizeScreen{
    [UIView animateWithDuration:.5f animations:^{
        [self showStatusBar];
        UIApplication *application=[UIApplication sharedApplication];
        application.keyWindow.transform=CGAffineTransformMakeRotation(0);
        application.keyWindow.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
        [application setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];

        _playerView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
        _redBtn.frame = CGRectMake(0, 0, 30, 30);
        _greenBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, 0, 30, 30);
        _blueBtn.frame = CGRectMake(0, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
        _yellowBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.alpha = 0;
    }];
}



- (void)showStatusBar {
    UIWindow *statusBarWindow = [(UIWindow *)[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
    CGRect frame = statusBarWindow.frame;
    frame.origin.y = 0;
    statusBarWindow.frame = frame;
}

- (void)hideStatusBar {
    UIWindow *statusBarWindow = [(UIWindow *)[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
    CGRect frame = statusBarWindow.frame;
    CGSize statuBarFrameSize = [UIApplication sharedApplication].statusBarFrame.size;
    frame.origin.y = -statuBarFrameSize.height;
    statusBarWindow.frame = frame;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}
@end
