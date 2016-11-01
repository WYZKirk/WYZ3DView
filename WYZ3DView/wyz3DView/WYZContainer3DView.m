/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */
#import "WYZContainer3DView.h"
#import "WYZInsert3DView.h"
#import "WYZOuter3DView.h"

@implementation WYZContainer3DView{
    CGFloat _edgeheight;
    CGFloat _edgeweight;
    CGFloat _edgedeep;
    CGFloat _angel;
    CATransform3D trans;
    NSInteger _storey3DCount;
    NSInteger _part3DCountx;
    NSInteger _part3DCounty;
    NSArray<NSArray<NSArray<NSNumber*>*>*>* _tempArr;
    NSMutableArray<WYZInsert3DView*>* _insert3DViewsArr;
    NSMutableArray<NSArray<UIView*>*>* _allShowViews;
    
    float _maxNumber;
    float _minNumber;
    UIColor *_sameColor;
    
    CGFloat _angel1;
    CGFloat _angel2;
    
    CGFloat blockBorder;
    
    CGPoint _sCenter;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        blockBorder = 60;
        self.backgroundColor = [UIColor whiteColor];
        trans = CATransform3DIdentity;
        trans.m34 = -1/500;
        _storey3DCount = 4;
        _part3DCountx = 4;
        _part3DCounty = 4;
        _edgeheight = (_storey3DCount+1)*blockBorder;
        _edgeweight = _part3DCountx*blockBorder;
        _edgedeep = _partCounty*blockBorder;
        _angel = -M_PI/4;
        _angel1 = _angel;
        _angel2 = _angel;
        _minNumber = 0;
        _maxNumber = 40;
        _insert3DViewsArr = [[NSMutableArray alloc]init];
        _allShowViews = [[NSMutableArray alloc]init];
        _sCenter = CGPointMake(frame.size.width/2, frame.size.height/2);
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        pan.minimumNumberOfTouches = 2;
        pan.maximumNumberOfTouches = 2;
        
        [self addGestureRecognizer:pan];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [self setOuterView];
    [self setInsertView];
    
    CATransform3D selfTrans = CATransform3DMakeRotation(_angel/2 , 0, 1 , 0);
    selfTrans = CATransform3DRotate(selfTrans, _angel/2 , 1, 0 , 0);
    self.layer.sublayerTransform = selfTrans;
}

-(void)setOuterView{
    WYZOuter3DView *outerBackView = [[WYZOuter3DView alloc]initWithFrame:CGRectMake(0, 0, _edgeweight, _edgeheight)];
    outerBackView.partCount = _part3DCountx;
    outerBackView.storeyCount = _storey3DCount;
    outerBackView.center = _sCenter;
    [self addSubview:outerBackView];
    
    WYZOuter3DView *outerLeftView = [[WYZOuter3DView alloc]initWithFrame:CGRectMake(0, 0, _edgedeep, _edgeheight)];
    outerLeftView.partCount = _part3DCounty;
    outerLeftView.storeyCount = _storey3DCount;
    outerLeftView.center = _sCenter;
    [self addSubview:outerLeftView];
    
    WYZOuter3DView *outerBottomView = [[WYZOuter3DView alloc]initWithFrame:CGRectMake(0, 0, _edgeweight, _edgedeep)];
    outerBottomView.partCount = _part3DCountx;
    outerBottomView.storeyCount = _part3DCounty-1;
    outerBottomView.center = _sCenter;
    [self addSubview:outerBottomView];
    
    CATransform3D trans2 = CATransform3DTranslate(trans, 0, 0, -_edgedeep/2);
    outerBackView.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, -_edgeweight/2, 0, 0);
    trans2 = CATransform3DRotate(trans2, M_PI_2, 0, 1, 0);
    outerLeftView.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, 0, _edgeheight/2, 0);
    trans2 = CATransform3DRotate(trans2, M_PI_2, 1, 0, 0);
    outerBottomView.layer.transform = trans2;
}

-(void)setInsertView{
    for (int i=0; i<_storey3DCount; i++) {
        WYZInsert3DView *insertView = [[WYZInsert3DView alloc]initWithFrame:CGRectMake(0, 0, _edgeweight, _edgedeep)];
        insertView.center = _sCenter;
        [self addSubview:insertView];
        [_insert3DViewsArr addObject:insertView];
        
        CATransform3D trans2 = CATransform3DTranslate(trans, 0, _edgeheight/2-_edgeheight*(_storey3DCount-i)/(_storey3DCount+1), 0);
        trans2 = CATransform3DRotate(trans2, M_PI_2, 1, 0, 0);
        insertView.layer.transform = trans2;
        NSMutableArray<UIView*> *storeyShowViews = [[NSMutableArray alloc]init];
        for (int parRow = 0; parRow<_part3DCounty; parRow++) {
            for (int parColumn=0; parColumn<_part3DCountx; parColumn++) {
                UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake((insertView.bounds.size.width-2)/_part3DCountx*parColumn+2, (insertView.bounds.size.height-2)/_part3DCounty*parRow+2, (insertView.bounds.size.width-(_part3DCountx+1)*2)/_part3DCountx, (insertView.bounds.size.height-(_part3DCounty+1)*2)/_part3DCounty)];
                locationView.backgroundColor = [UIColor grayColor];
                [insertView addSubview:locationView];
                UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, locationView.frame.size.width, 30)];
                CGPoint locationP = [insertView convertPoint:locationView.center toView:self];
                showView.center = CGPointMake(locationP.x, locationP.y-6);
                [self addSubview:showView];
                [storeyShowViews addObject:showView];
                
                UILabel *showLbl = [[UILabel alloc]initWithFrame:showView.bounds];
                showLbl.textColor = [UIColor blackColor];
                showLbl.textAlignment = NSTextAlignmentCenter;
                
                showLbl.font = [UIFont systemFontOfSize:9];
                [showView addSubview:showLbl];
                CATransform3D showTrans = CATransform3DMakeTranslation(0, 0,insertView.bounds.size.height/_part3DCounty*(parRow+1)-15-insertView.bounds.size.height/2);
                showTrans = CATransform3DRotate(showTrans, M_PI_4, 1, 0, 0);
                showView.layer.transform = showTrans;
                if (_tempArr != nil) {
                    if (_tempArr.count>i) {
                        if (_tempArr[i].count>parRow) {
                            if (_tempArr[i][parRow].count>parColumn) {
                                if (_tempArr[i][parRow][parColumn].floatValue  != MAXFLOAT) {
                                    float totalNumber = (_maxNumber-_minNumber)/4;
                                    float eachValue = _tempArr[i][parRow][parColumn].floatValue;
                                    if (_sameColor == nil) {
                                        CGFloat redf = eachValue>2*totalNumber?(eachValue<3*totalNumber?(eachValue-2*totalNumber)/totalNumber:1):0;
                                        CGFloat greenf = eachValue>totalNumber?(eachValue>3*totalNumber?(4*totalNumber-eachValue)/totalNumber:1):eachValue/totalNumber;
                                        CGFloat bluef = eachValue>totalNumber?(eachValue>2*totalNumber?0:(2*totalNumber-eachValue)/totalNumber):1;
                                        locationView.backgroundColor = [[UIColor alloc]initWithRed:redf green:greenf blue:bluef alpha:1];
                                    }else{
                                        locationView.backgroundColor = _sameColor;
                                    }
                                    
                                    showLbl.text = [NSString stringWithFormat:@"%.2f",eachValue];
                                }else{
                                    showLbl.text = @"";
                                }
                            }else{
                                showLbl.text = @"";
                            }
                        }else{
                            showLbl.text = @"";
                        }
                    }else{
                        showLbl.text = @"";
                    }
                }else{
                    showLbl.text = @"";
                }
            }
        }
        [_allShowViews addObject:storeyShowViews];
    }
    
}



-(void)handlePan:(UIPanGestureRecognizer*) sender{
    if (sender.maximumNumberOfTouches == 2 && sender.minimumNumberOfTouches == 2) {
        CGPoint p=[sender translationInView:self];
        CGFloat angel1 = _angel1+p.x/30;
        CGFloat angel2 = _angel2-p.y/30;
        
        if (sender.state == UIGestureRecognizerStateEnded) {
            _angel1 = angel1;
            _angel2 = angel2;
        }
        
        CATransform3D panTrans = CATransform3DIdentity;
        panTrans.m34 = -1/500;
        panTrans = CATransform3DRotate(panTrans, angel1, 0, 1, 0);
        panTrans = CATransform3DRotate(panTrans, angel2, 1, 0, 0);
        self.layer.sublayerTransform = panTrans;
    }
    
}


//赋值
-(void)setStoreyCount:(NSInteger)storeyCount{
    _storey3DCount = storeyCount;
    _edgeheight = (storeyCount+1)*blockBorder;
}
-(void)setPartCountx:(NSInteger)partCountx{
    _part3DCountx = partCountx;
    _edgeweight = partCountx*blockBorder;
}
-(void)setPartCounty:(NSInteger)partCounty{
    _part3DCounty = partCounty;
    _edgedeep = partCounty*blockBorder;
}
-(void)setDataArr:(NSArray<NSArray<NSArray<NSNumber *>*> *> *)dataArr{
    _tempArr = dataArr;
}
-(void)setStoreyIsHiddenArr:(NSArray<NSNumber *> *)storeyIsHiddenArr{
    if (storeyIsHiddenArr == nil) {
        return;
    }
    for (int i = 0; i<_insert3DViewsArr.count; i++) {
        BOOL isHidden;
        if (i<storeyIsHiddenArr.count) {
            isHidden = storeyIsHiddenArr[i].boolValue;
        }else{
            isHidden = NO;
        }
        _insert3DViewsArr[i].hidden = isHidden;
        for (int j = 0; j<_allShowViews[i].count; j++) {
            _allShowViews[i][j].hidden = isHidden;
        }
    }
}
-(void)setMaxColorNumber:(float)maxColorNumber{
    _maxNumber = maxColorNumber;
}
-(void)setMinColorNumber:(float)minColorNumber{
    _minNumber = minColorNumber;
}
-(void)setSameBackgroudColor:(UIColor *)sameBackgroudColor{
    _sameColor = sameBackgroudColor;
}



@end
