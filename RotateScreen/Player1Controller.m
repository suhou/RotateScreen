//
//  Player1Controller.m
//  RotateScreen
//
//  Created by bifangao on 16/7/12.
//  Copyright © 2016年 bifangao. All rights reserved.
//

#import "Player1Controller.h"

@interface Player1Controller ()
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *blueBtn;
@property (nonatomic, strong) UIButton *greenBtn;
@property (nonatomic, strong) UIButton *yellowBtn;
//@property (nonatomic, assign) BOOL stautsBarFlag;
@end

@implementation Player1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [btn2 addTarget:self action:@selector(layTestView) forControlEvents:UIControlEventTouchUpInside];
    _greenBtn = btn2;
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(playerView.frame) - 30, 30, 30)];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 addTarget:self action:@selector(rotateWholeView) forControlEvents:UIControlEventTouchUpInside];
    _blueBtn = btn3;
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(playerView.frame) - 30, CGRectGetHeight(playerView.frame) - 30, 30, 30)];
    btn4.backgroundColor = [UIColor yellowColor];
    [btn4 addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
    _yellowBtn = btn4;
    
    [playerView addSubview:btn1];
    [playerView addSubview:btn2];
    [playerView addSubview:btn3];
    [playerView addSubview:btn4];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
}

- (void)fullScreen{
    NSLog(@"123");
    [UIView animateWithDuration:.5f animations:^{
        [self hideStatusBar];
        _playerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/2);
        _playerView.frame = self.view.frame;
        _redBtn.frame = CGRectMake(0, 0, 30, 30);
        _greenBtn.frame = CGRectMake(CGRectGetHeight(_playerView.frame) - 30, 0, 30, 30);
        _blueBtn.frame = CGRectMake(0, CGRectGetWidth(_playerView.frame) - 30, 30, 30);
        _yellowBtn.frame = CGRectMake(CGRectGetHeight(_playerView.frame) - 30, CGRectGetWidth(_playerView.frame) - 30, 30, 30);
    }];
}

- (void)rotateWholeView{
    [UIView animateWithDuration:.5f animations:^{
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
        
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.alpha = 0;
//        self.view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    }];
}

- (void)layTestView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
}

- (void)resizeScreen{
    [UIView animateWithDuration:.5f animations:^{
        [self showStatusBar];
        _playerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
        _playerView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
        _redBtn.frame = CGRectMake(0, 0, 30, 30);
        _greenBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, 0, 30, 30);
        _blueBtn.frame = CGRectMake(0, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
        _yellowBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(current));
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

/**
 *  这个属性决定了横屏是是否自动旋转，也就是player4中横过来会自动更改坐标系的原因（长宽交换）
 *
 *  @return 是否自动旋转
 */
-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

-(void)orientationChanged:(NSNotification *)notifi{
    NSLog(@"123");
}
@end
