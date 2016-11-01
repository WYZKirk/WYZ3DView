/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */
#import "WYZInsert3DView.h"

@implementation WYZInsert3DView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [[UIColor alloc]initWithRed:148.0/255.0 green:159.0/255.0 blue:6.0/255.0 alpha:1];
    return self;
}


@end
