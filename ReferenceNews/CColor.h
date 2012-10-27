//
//  CColor.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#ifndef ReferenceNews_CColor_h
#define ReferenceNews_CColor_h

///////////////////////////////////////////////////////////////////////////////////////////////////
// Color helpers - from three20 > http://three20.info

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0, (g)/255.0, (b)/255.0, (a)
#define NAV_BAR_COLOR [UIColor colorWithRed:154/255.0 green:47/255.0 blue:44/255.0 alpha:1]
#endif
