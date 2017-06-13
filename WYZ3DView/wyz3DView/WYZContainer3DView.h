/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */

#import <UIKit/UIKit.h>

@interface WYZContainer3DView : UIView
@property (nonatomic,assign) NSInteger storeyCount;
@property (nonatomic,assign) NSInteger partCountx;
@property (nonatomic,assign) NSInteger partCounty;
@property (nonatomic,strong) NSArray<NSArray<NSArray<id>*>*>* dataArr;
@property (nonatomic,strong) NSArray<NSNumber*>* storeyIsHiddenArr;
@property (nonatomic,assign) float maxColorNumber;
@property (nonatomic,assign) float minColorNumber;
@property (nonatomic,strong) UIColor* sameBackgroudColor;
@property (nonatomic,assign) CGFloat blockBorder;
@property (nonatomic,assign) CGFloat blockFont;
@end
