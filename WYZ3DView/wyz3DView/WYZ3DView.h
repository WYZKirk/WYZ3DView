/*
 by:kirk wei
 
 storeyCount,partCountx,partCounty数请不要超过90
 
 dataArr数据是从最里横向以此向外写入
 
 storeyIsHiddenArr:用于确定每行是否需要显示
 
 单指用于移动图像位置,双指同向移动用于移动立体图形旋转,双指异向用于放大缩小.
 
 */

#import <UIKit/UIKit.h>

@interface WYZ3DView : UIScrollView
@property (nonatomic,assign) NSInteger storeyCount;//层数 默认4
@property (nonatomic,assign) NSInteger partCountx;//x面列数(后面)默认4
@property (nonatomic,assign) NSInteger partCounty;//y面列数(左面)默认4
@property (nonatomic,strong) NSArray<NSArray<NSArray<NSNumber*>*>*>* dataArr;//输入的数据,用@MAXFLOAT设置无数据状态,为填写的数据默认为无数据状态
@property (nonatomic,strong) NSArray<NSNumber*>* storeyIsHiddenArr;//每层是否隐藏
@property (nonatomic,assign) float maxColorNumber;//颜色变化最大值(红色)默认40
@property (nonatomic,assign) float minColorNumber;//颜色变化最小值(蓝色)默认0
@property (nonatomic,strong) UIColor* sameBackgroudColor;//默认nil  加入颜色所有面都为同一颜色
@property (nonatomic,assign) CGFloat blockBorder;//默认为60.用于设置每层小方块的大小.
@property (nonatomic,assign) CGFloat blockFont;//默认为10.用于设置字体

@end
