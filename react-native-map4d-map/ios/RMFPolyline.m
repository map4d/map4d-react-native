//
//  RMFPolyline.m
//  Map4dMap
//
//  Created by Huy Dang on 7/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "RMFPolyline.h"
#import <Foundation/Foundation.h>

@implementation RMFPolyline

- (instancetype)init {
  if ((self = [super init])) {
    _map4dPolyline = [[RMFPolylineMap4d alloc] init];
    _map4dPolyline.reactPolyline = self;
    
    _coordinates = nil;
    _width = _map4dPolyline.width;
    _lineStyle = @"solid";//MFPolylineStyleSolid
    _color = _map4dPolyline.color;
    _zIndex = _map4dPolyline.zIndex;
    _visible = true;//!_map4dPolyline.isHidden
  }
  return self;
}

- (void)setMapView:(RMFMapView *)mapView {
  _map4dPolyline.map = mapView;
}

/** Properties */

- (void)setCoordinates:(NSArray<MFCoordinate *> *)coordinates {
  _coordinates = coordinates;
  MFMutablePath* path = [[MFMutablePath alloc] init];
  for(int i = 0; i < coordinates.count; i++)
  {
    [path addCoordinate:coordinates[i].coordinate];
  }
  _map4dPolyline.path = path;
}

- (void)setWidth:(CGFloat)width {
  _width = width;
  _map4dPolyline.width = width;
}

- (void)setColor:(UIColor *)color {
  _color = color;
  _map4dPolyline.color = color;
}

- (void)setLineStyle:(NSString *)lineStyle {
  _lineStyle = lineStyle;
  if ([lineStyle isEqualToString:@"dotted"]) {
    _map4dPolyline.style = MFPolylineStyleDotted;
  } else {
    _map4dPolyline.style = MFPolylineStyleSolid;
  }
}

- (void)setZIndex:(float)zIndex {
  _zIndex = zIndex;
  _map4dPolyline.zIndex = zIndex;
}

- (void)setVisible:(BOOL)visible {
  _visible = visible;
  _map4dPolyline.isHidden = !visible;
}

/** Event */

- (void)didTap {
  if (!self.onPress) return;
  RMFPolylineMap4d* polyline = self.map4dPolyline;
  self.onPress(
    @{
      @"id": @(polyline.Id)
    }
  );
}

@end