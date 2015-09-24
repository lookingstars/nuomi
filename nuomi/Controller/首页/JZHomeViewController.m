//
//  JZHomeViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeViewController.h"
#import "JZHomeShopCell.h"
#import "JZHomeNewCell.h"

@interface JZHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;






@end

@implementation JZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OnSaoyisaoBtn:(UIButton *)sender {
    NSLog(@"扫一扫");
}

- (IBAction)OnGouwucheBtn:(UIButton *)sender {
    NSLog(@"购物车");
}

- (IBAction)OnMoreCityBtn:(id)sender {
    NSLog(@"选择城市");
}

#pragma mark - **************** UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 96;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"JZHomeNewCell";
        JZHomeNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
        //赋值
        return cell;
    }else{
        static NSString *cellIndentifier = @"JZHomeShopCell";
        JZHomeShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
        //赋值
        return cell;
    }
}




#pragma mark - **************** UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
