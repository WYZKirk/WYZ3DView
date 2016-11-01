/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */

#import "WYZOuter3DView.h"

@implementation WYZOuter3DView{
    NSInteger _outStoreyCount;
    NSInteger _outPartCount;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [[UIColor alloc]initWithRed:240.0/255.0 green:237.0/255.0 blue:213.0/255.0 alpha:1];
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGFloat color[] = {240.0/255.0,145.0/255.0,141.0/255.0,1};
    CGContextSetStrokeColor(ref, color);
    CGContextSetLineWidth(ref, 2);
    for (int i=0; i< _outStoreyCount+2; i++) {
        CGContextMoveToPoint(ref, 0, (self.bounds.size.height-1)/( _outStoreyCount+1)*i);
        CGContextAddLineToPoint(ref, self.bounds.size.width, (self.bounds.size.height-1)/( _outStoreyCount+1)*i);
    }
    for (int i=0; i<_outPartCount+1; i++) {
        CGContextMoveToPoint(ref, (self.bounds.size.width-1)/_outPartCount*i, 0);
        CGContextAddLineToPoint(ref, (self.bounds.size.width-1)/_outPartCount*i, self.bounds.size.height);
    }
    CGContextDrawPath(ref, kCGPathStroke);
}

-(void)setStoreyCount:(NSInteger)storeyCount{
    _outStoreyCount = storeyCount;
}

-(void)setPartCount:(NSInteger)partCount{
    _outPartCount = partCount;
}

@end
