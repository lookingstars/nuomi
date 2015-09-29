//
//  JZShopNoticeCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopNoticeCell.h"

#define sysVersion [[[UIDevice currentDevice] systemVersion] floatValue]


@implementation JZShopNoticeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(NSString *)notice{
    
    CGSize textBlockMinSize = {screen_width-16, CGFLOAT_MAX};
    CGSize labelsize;
    //介绍内容
    NSString *content = notice;
    if (sysVersion >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];//调整行间距
        labelsize = [content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                    NSParagraphStyleAttributeName:paragraphStyle
                                                    }
                                          context:nil].size;
    }else{
        labelsize = [content sizeWithFont:[UIFont systemFontOfSize:12]
                        constrainedToSize:textBlockMinSize
                            lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    
    return labelsize.height+16;
}
@end
