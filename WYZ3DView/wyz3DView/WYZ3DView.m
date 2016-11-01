/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */

#import "WYZ3DView.h"
#import "WYZContainer3DView.h"

@interface WYZ3DView()<UIScrollViewDelegate>

@end

@implementation WYZ3DView{
    WYZContainer3DView *containView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.bouncesZoom = NO;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        _storeyCount = 4;
        _partCountx = 4;
        _partCounty = 4;
        _maxColorNumber = 40;
        _minColorNumber = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (containView == nil) {
        CGFloat conWidth = sqrt(_partCountx*_partCountx+_storeyCount*_storeyCount+_partCounty*_partCounty)*60;
        CGFloat conHeigth = conWidth;
        CGFloat minScale = self.frame.size.width/conWidth;
        if (conWidth < self.frame.size.width&&conHeigth < self.frame.size.height) {
            conWidth = self.frame.size.width;
            conHeigth = self.frame.size.height;
            minScale = 1;
        }else if(conHeigth < self.frame.size.height){
            conHeigth = self.frame.size.height;
            minScale = 1;
        }else if(conWidth < self.frame.size.width){
            conWidth = self.frame.size.width;
            minScale = 1;
        }else{
            if (conWidth/self.frame.size.width < conHeigth/self.frame.size.height){
                minScale = self.frame.size.width/conWidth;
            }else{
                minScale = self.frame.size.height/conHeigth;
            }
        }
        self.maximumZoomScale = 1;
        self.minimumZoomScale = minScale;
        self.contentSize = CGSizeMake(conWidth, conHeigth);
        self.contentOffset = CGPointMake((conWidth-self.frame.size.width)/2, (conHeigth-self.frame.size.height)/2);
        containView = [[WYZContainer3DView alloc]initWithFrame:CGRectMake(0, 0, conWidth, conHeigth)];
        containView.storeyCount = _storeyCount;
        containView.partCountx = _partCountx;
        containView.partCounty = _partCounty;
        containView.dataArr = _dataArr;
        containView.storeyIsHiddenArr = _storeyIsHiddenArr;
        containView.maxColorNumber = _maxColorNumber;
        containView.minColorNumber = _minColorNumber;
        containView.sameBackgroudColor = _sameBackgroudColor;
        [self addSubview:containView];
        self.zoomScale = self.minimumZoomScale;
    }
}

#pragma mark UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return containView;
}

-(void)setStoreyIsHiddenArr:(NSArray<NSNumber *> *)storeyIsHiddenArr{
    _storeyIsHiddenArr = storeyIsHiddenArr;
    if (containView != nil) {
        containView.storeyIsHiddenArr = storeyIsHiddenArr;
    }
}

@end
