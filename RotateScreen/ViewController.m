//
//  ViewController.m
//  RotateScreen
//
//  Created by bifangao on 16/7/11.
//  Copyright © 2016年 bifangao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *blueBtn;
@property (nonatomic, strong) UIButton *greenBtn;
@property (nonatomic, strong) UIButton *yellowBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@"原地旋转", @"全部旋转(Window)", @"原地旋转＋横屏", @"全部旋转＋横屏(device)", @"全部旋转＋横屏(window)"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.title = @"选择模式";
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
//    [self customUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)customUserInterface{
    CGRect frame = self.view.frame;
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)/3)];
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
    _blueBtn = btn3;
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(playerView.frame) - 30, CGRectGetHeight(playerView.frame) - 30, 30, 30)];
    btn4.backgroundColor = [UIColor yellowColor];
    [btn4 addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
    _yellowBtn = btn4;
    
    [playerView addSubview:btn1];
    [playerView addSubview:btn2];
    [playerView addSubview:btn3];
    [playerView addSubview:btn4];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
}

- (void)fullScreen{
    NSLog(@"123");
    [UIView animateWithDuration:.5f animations:^{
        _playerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/2);
        _playerView.frame = self.view.frame;
        _redBtn.frame = CGRectMake(0, 0, 30, 30);
        _greenBtn.frame = CGRectMake(CGRectGetHeight(_playerView.frame) - 30, 0, 30, 30);
        _blueBtn.frame = CGRectMake(0, CGRectGetWidth(_playerView.frame) - 30, 30, 30);
        _yellowBtn.frame = CGRectMake(CGRectGetHeight(_playerView.frame) - 30, CGRectGetWidth(_playerView.frame) - 30, 30, 30);
    }];
}

- (void)resizeScreen{
    [UIView animateWithDuration:.5f animations:^{
        _playerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
        _playerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
        _redBtn.frame = CGRectMake(0, 0, 30, 30);
        _greenBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, 0, 30, 30);
        _blueBtn.frame = CGRectMake(0, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
        _yellowBtn.frame = CGRectMake(CGRectGetWidth(_playerView.frame) - 30, CGRectGetHeight(_playerView.frame) - 30, 30, 30);
    }];
}

#pragma mark - UITableViewDataSource && delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *label = [[UILabel alloc] init];
    label.text = _dataSource[indexPath.row];
    [label sizeToFit];
    [cell.contentView addSubview:label];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idx = [NSString stringWithFormat:@"%li", indexPath.row + 1];
    UIViewController *playerVC = [[NSClassFromString([NSString stringWithFormat:@"Player%@Controller", idx] )alloc] init];
    [self.navigationController pushViewController:playerVC animated:YES];
}
@end
