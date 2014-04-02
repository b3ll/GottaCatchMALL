//
//  GottaCatchMAll.m
//  Gotta Catch 'M ALL
//
//  Created by Adam Bell on 2014-04-01.
//  Copyright (c) 2014 Adam Bell. All rights reserved.
//

@interface OdelayProtoUtil

@end

@interface GSPointProto : NSObject

@property(nonatomic) int latE7;
@property(nonatomic) int lngE7;

@end

@interface PMOAshLayer_AshIcon : NSObject

@property(retain, nonatomic) GSPointProto *location;

@property(nonatomic) int ashTypeIndex;
@property(nonatomic) int capturesRequired;
@property(nonatomic) int catchableDistanceMaxMeters;
@property(nonatomic) int iconDisplaySize;
@property(nonatomic) long long id_p;
@property(nonatomic) BOOL isClickable;
@property(nonatomic) int minZoomLevel;

@end

@interface PMOAshLayer_AshType : NSObject

@property(retain, nonatomic) NSString *detailImageUrl;
@property(retain, nonatomic) NSString *modalCaptureTitle;
@property(retain, nonatomic) NSString *name;
@property(nonatomic) int spriteIndex;

@end

@interface PBMutableArray : NSObject

@property(readonly, nonatomic) NSUInteger count;

- (id)lastObject;
- (void)addObject:(id)object;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

@interface PMOAshLayer : NSObject

@property(retain, nonatomic) PBMutableArray *ashArray;
@property(retain, nonatomic) PBMutableArray *ashTypeArray;

@end
