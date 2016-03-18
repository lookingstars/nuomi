//
//  JZTopicViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZTopicViewController.h"
#import "JZTopicImageCell.h"
#import "JZTopicListCell.h"
#import "JZNetworkSingleton.h"
#import "JZTopicModel.h"

@interface JZTopicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) JZTopicModel *topicM;

@end

@implementation JZTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self initData];
    [self setUpTableView];
    
    NSLog(@"specialid:%@",self.specialid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData {
    _dataSource = [[NSMutableArray alloc] init];
}

//MJRefresh下拉刷新，跟上一个版本比，有的方法变了，具体用发要参考源码
-(void)setUpTableView{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    //    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header = [JZNuomiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

-(void)loadNewData{
    [self requestData];
}

//197611
//    url内部添加有签名加密，所以只能把url写死，不能动态的改变url
-(void)requestData {
    NSString *url1 = @"http://112.80.255.88/naserver/home/special?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&goods_per_page=15&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989320%2C116.324530&logpage=ActivityList&net=wifi&os=8.2&page_idx=1&sheight=1334&sign=ee82e43ea40205f921e60fefe63fe138";
    NSString *url2 = @"&swidth=750&terminal_type=ios&timestamp=1443415146869&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
//    NSString *url = [NSString stringWithFormat:@"%@&special_id=%@%@",url1,self.specialid,url2];
    NSString *url = [NSString stringWithFormat:@"%@&special_id=%@%@",url1,@"197611",url2];
    
//    NSString *url = @"http://112.80.255.88/naserver/home/special";
    //采用这种方式请求不到数据，服务器提示『签名错误』
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"ios" forKey:@"appid"];
    [dic setObject:@"" forKey:@"bduss"];
    [dic setObject:@"com_dot_apple" forKey:@"channel"];
    [dic setObject:@"100010000" forKey:@"cityid"];
    [dic setObject:@"11a2e62839f7bed05437dcb826be61a0c47a515c" forKey:@"cuid"];
    [dic setObject:@"iPhone" forKey:@"device"];
    [dic setObject:@"15" forKey:@"goods_per_page"];
    [dic setObject:@"5" forKey:@"ha"];
    [dic setObject:@"ACAF9226-F987-417B-A708-C95D482A732D" forKey:@"lbsidfa"];
    [dic setObject:@"39.989320/116.324530" forKey:@"location"];
    [dic setObject:@"ActivityList" forKey:@"logpage"];
    [dic setObject:@"wifi" forKey:@"net"];
    [dic setObject:@"8.2" forKey:@"os"];
    [dic setObject:@"1" forKey:@"page_idx"];
    [dic setObject:@"1334" forKey:@"sheight"];
    [dic setObject:@"ee82e43ea40205f921e60fefe63fe138" forKey:@"sign"];
    [dic setObject:@"197611" forKey:@"special_id"];//$$$
    [dic setObject:@"750" forKey:@"swidth"];
    [dic setObject:@"ios" forKey:@"terminal_type"];
    [dic setObject:@"1443415146869" forKey:@"timestamp"];
    [dic setObject:@"ios" forKey:@"tn"];
    [dic setObject:@"11a2e62839f7bed05437dcb826be61a0c47a515c" forKey:@"uuid"];
    [dic setObject:@"v" forKey:@"5.13.0"];
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZTopicModel";
    
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 topic 数据成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        if (responseObject.code == 0) {
            weakself.topicM = responseObject.data;
            _dataSource = [NSMutableArray arrayWithArray:self.topicM.special_list];
        }else{
            NSLog(@"%@",responseObject.errmsg);
        }
        
        
        
        [weakself.tableView reloadData];
        [weakself.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"请求 topic 数据失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];

}


#pragma mark - **************** UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count == 0) {
        return 0;
    }
    return _dataSource.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 220;
    }else{
        return 90;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"topicImgCell";
        JZTopicImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        //赋值
        
        NSString *imgStr = [NSString convertImgStr:self.topicM.special_image];
        [cell.bigImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"account_place_holder"]];
        
        return cell;
    }else{
        static NSString *cellIndentifier = @"topicListCell";
        JZTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        //赋值
        if (_dataSource.count>0) {
            JZTopicSpecialModel *specialM = _dataSource[indexPath.row - 1];
            [cell setSpecialM:specialM];
        }
        
        return cell;
    }
}


#pragma mark - **************** UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
