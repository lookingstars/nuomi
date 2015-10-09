//
//  JZCityViewController.m
//  CitySortDemo
//
//  Created by jinzelu on 15/8/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZCityViewController.h"

//#define screen_width [UIScreen mainScreen].bounds.size.width
//#define screen_height [UIScreen mainScreen].bounds.size.height

@interface JZCityViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  当前城市数据源，服务器取
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  索引数据源
 */
@property (nonatomic, strong) NSMutableArray *indexSource;

@end

@implementation JZCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initNav];
    [self initData];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = RGB(241, 241, 241);
    [self.view addSubview:backView];
    //退出
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(20, 30, 20, 20);
    [closeBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(OnCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-50, 30, 100, 25)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"选择城市";
    [backView addSubview:titleLabel];
}

-(void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionIndexColor = navigationBarColor;
    [self.view addSubview:self.tableView];
}

-(void)initData {
    self.dataSource = [[NSMutableArray alloc] init];
    self.indexSource = [[NSMutableArray alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *city = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    _dataSource = [self sortArray:city];
}

-(void)OnCloseBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//排序并按首字母分组
-(NSMutableArray *)sortArray:(NSMutableArray *)arrayToSort {
    NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
    
    //根据拼音对数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //排序
    [arrayToSort sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArray = nil;
    BOOL flag = NO;
    
    //分组
    for (int i = 0; i < arrayToSort.count; i++) {
        NSString *pinyin = [arrayToSort[i] objectForKey:@"pinyin"];
        NSString *firstChar = [pinyin substringToIndex:1];
        //        NSLog(@"%@",firstChar);
        if (![_indexSource containsObject:[firstChar uppercaseString]]) {
            [_indexSource addObject:[firstChar uppercaseString]];
            tempArray = [[NSMutableArray alloc] init];
            flag = NO;
        }
        if ([_indexSource containsObject:[firstChar uppercaseString]]) {
            [tempArray addObject:arrayToSort[i]];
            if (flag == NO) {
                [arrayForArrays addObject:tempArray];
                flag = YES;
            }
        }
    }
    
    return arrayForArrays;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_indexSource objectAtIndex:section];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _indexSource;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"selectedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
