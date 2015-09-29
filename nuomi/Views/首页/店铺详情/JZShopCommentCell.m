//
//  JZShopCommentCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopCommentCell.h"
#define sysVersion [[[UIDevice currentDevice] systemVersion] floatValue]
@implementation JZShopCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCommentM:(JZShopDetailCommentModel *)commentM {
    _commentM = commentM;
    
    self.userNameLabel.text = commentM.nickname;
    self.contentLabel.text = commentM.content;
    
    NSUInteger timestamp = [commentM.update_time integerValue];
    NSDate *formattedDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.updateTimeLabel.text = [outputFormatter stringFromDate:formattedDate];
    
    
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(JZShopDetailCommentModel *)commentM{
    
    CGSize textBlockMinSize = {screen_width-16, CGFLOAT_MAX};
    CGSize labelsize;
    //介绍内容
    NSString *content = commentM.content;
    if (sysVersion >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];//调整行间距
        labelsize = [content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName:[UIFont systemFontOfSize:14],
                                                    NSParagraphStyleAttributeName:paragraphStyle
                                                    }
                                          context:nil].size;
    }else{
        labelsize = [content sizeWithFont:[UIFont systemFontOfSize:14]
                        constrainedToSize:textBlockMinSize
                            lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    
    
    
    return labelsize.height + 27 +10;
}

@end
