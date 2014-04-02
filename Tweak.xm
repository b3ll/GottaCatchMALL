//
//  Tweak.xm
//  Gotta Catch 'M ALL
//
//  Created by Adam Bell on 2014-04-01.
//  Copyright (c) 2014 Adam Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GottaCatchMAll.h"

// All network requests (including images) need to be on HTTPS urls :/
#define MISSINGNO_FULL_IMAGE_URL @"https://drive.google.com/uc?export=download&id=0B12P9Z81cprMX0o4dkNSWFFxUXM"
#define MISSINGNO_INFO_URL @"https://drive.google.com/uc?export=download&id=0B12P9Z81cprMWFRuVmVWMklhSXM"
#define ALTERED_SPRITE_SHEET_URL @"https://drive.google.com/uc?export=download&id=0B12P9Z81cprMb09vLWZrNDBEanc"

__weak PMOAshLayer *_ashLayer;

%hook OdelayProtoUtil

+ (PMOAshLayer *)ashLayer {
    PMOAshLayer *ashLayer = %orig;

    if (_ashLayer != ashLayer) {
        _ashLayer = ashLayer;

        PBMutableArray *typeArray = ashLayer.ashTypeArray;

        // Creates the type information, image and name details
        PMOAshLayer_AshType *missingnoType = [[%c(PMOAshLayer_AshType) alloc] init];

        // Blocking network call I know... #yolo
        // Also I download the file because some editors explode when rendering those glitchy characters
        NSString *name = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:MISSINGNO_INFO_URL]] encoding: NSUTF8StringEncoding];
        missingnoType.name = name;
        missingnoType.modalCaptureTitle = [NSString stringWithFormat:@"%@ was caught!", name];
        missingnoType.spriteIndex = 153;
        missingnoType.detailImageUrl = MISSINGNO_FULL_IMAGE_URL;
        [typeArray setObject:missingnoType atIndexedSubscript:typeArray.count];

        // Creates the actual icon that'll be displayed on the map
        PMOAshLayer_AshIcon *missingnoIcon = [[%c(PMOAshLayer_AshIcon) alloc] init];
        missingnoIcon.ashTypeIndex = typeArray.count - 1;
        missingnoIcon.capturesRequired = 0;
        missingnoIcon.iconDisplaySize = 80;
        missingnoIcon.isClickable = YES;
        missingnoIcon.minZoomLevel = 18;
        missingnoIcon.id_p = 9001;

        // Location of Missingno
        GSPointProto *location = [[%c(GSPointProto) alloc] init];
        location.latE7 = 378084634;
        location.lngE7 = -1224061830;
        missingnoIcon.location = location;

        [ashLayer.ashArray addObject:missingnoIcon];
    }

    return ashLayer;
}

%end

// Use modified sprite sheet with Missingno sprite added
%hook PMOAshLayer

- (void)setSpriteAtlasImageUrl:(NSString *)imageURL {
    %orig(ALTERED_SPRITE_SHEET_URL);
}

- (NSString *)spriteAtlasImageUrl {
    return ALTERED_SPRITE_SHEET_URL;
}

%end
