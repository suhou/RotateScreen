//
//  Player5Controller.m
//  RotateScreen
//
//  Created by bifangao on 16/7/13.
//  Copyright © 2016年 bifangao. All rights reserved.
//

#import "Player5Controller.h"

@interface Player5Controller ()
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *blueBtn;
@property (nonatomic, strong) UIButton *greenBtn;
@property (nonatomic, strong) UIButton *yellowBtn;

@end

@implementation Player5Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0;
    [self customUserInterface];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self layTestBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layTestBtn{
    UIButton *blackBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 30, 30, 30)];
    blackBtn.backgroundColor = [UIColor blackColor];
    [blackBtn addTarget:self action:@selector(logTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blackBtn];
}

- (void)logTest{
    NSLog(@"123");
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
    NSLog(@"player5");
    [UIView animateWithDuration:.5f animations:^{
        if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
            [self rotateWindow:[[UIDevice currentDevice] orientation]];
        }else{
            [self rotateWindow:UIDeviceOrientationLandscapeRight];
        }
        
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.alpha = 0;
        [self prefersStatusBarHidden];
        [UIView animateWithDuration:.25f animations:^{
            [self hideStatusBar];
        }];
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
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}
/**
 *  设置了orientation之后UIScreen的方向改变了，但是uiwindow的frame并没有变
 */
//TODO: 可以在UIScreen方向改变后打印每个点的坐标系看看
- (void)rotateWindow:(UIDeviceOrientation) orientation{
    /**
     *  为什么这里这么麻烦，因为更改window自己在做transform的时候就是需要根据当前statusbar orientation要算transform的角度 T_T
     */
    UIInterfaceOrientation o;
    CGAffineTransform windowTransform;
    CGRect frame;
    switch (orientation) {
        case UIDeviceOrientationLandscapeLeft:
            o = UIInterfaceOrientationLandscapeRight;
            windowTransform = CGAffineTransformMakeRotation(M_PI/2);
            break;
        case UIDeviceOrientationLandscapeRight:
            o = UIInterfaceOrientationLandscapeLeft;
            windowTransform = CGAffineTransformMakeRotation(-M_PI / 2);
            break;
        default:
            break;
    }
    
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait:
            frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
        case UIInterfaceOrientationLandscapeRight:
            frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
        default:
            break;
    }
    
    UIApplication *application=[UIApplication sharedApplication];
    application.keyWindow.transform=windowTransform;
    application.keyWindow.frame = frame;
    [application setStatusBarOrientation:o animated:YES];
    
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


- (void)orientationChanged:(NSNotification *)notification{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            NSLog(@"UIDeviceOrientationPortrait");
            NSLog(@"uiscreen bounds is : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
            if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
                [self resizeScreen];
            }
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"UIDeviceOrientationLandscapeLeft");
            NSLog(@"uiscreen bounds is : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
            [self fullScreen];
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"UIDeviceOrientationLandscapeRight");
            NSLog(@"uiscreen bounds is : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
            [self fullScreen];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"UIDeviceOrientationPortraitUpsideDown");
            NSLog(@"uiscreen bounds is : %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(current));
}
@end
