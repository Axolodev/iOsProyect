//
//  FinalViewController.h
//  ProyectoFinal
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EliminarVistas <NSObject>
-(void) quitarVistas;

@end

@interface FinalViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lbGanoPerdio;

@property(strong,nonatomic) id <EliminarVistas> delegado;
@property  Boolean resultadoJugada;




@end
