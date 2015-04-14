//
//  JugarViewController.h
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JugarViewController : UIViewController
@property (nonatomic, strong) NSString *stDificultad;
@property (nonatomic, strong) NSString *stCategoria;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSMutableArray *arregloBotones;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSMutableArray *arregloBotonesPalabra;

@end
