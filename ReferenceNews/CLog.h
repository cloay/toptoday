//
//  CLog.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#ifndef ReferenceNews_CLog_h
#define ReferenceNews_CLog_h

#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif


#endif
