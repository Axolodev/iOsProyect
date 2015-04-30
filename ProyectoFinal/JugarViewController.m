//
//  JugarViewController.m
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "JugarViewController.h"
#import "FinalViewController.h"

@interface JugarViewController ()
@property const NSInteger BUTTONWIDTH;
@property const NSInteger BUTTONHEIGHT;
@property const NSInteger SPACEBETWEENBUTTONS;
@property const NSInteger STARTINGY;
@property const NSInteger STARTINGX;
@property NSInteger indice;
@property NSInteger score;
@end

@implementation JugarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self filtrarPalabrasDeDiccionario];
    
    self.BUTTONHEIGHT = 30;
    self.BUTTONWIDTH = 30;
    self.SPACEBETWEENBUTTONS = 7;
    self.STARTINGX = 20;
    self.STARTINGY = 300;
    self.tfPalabraAdivinada.hidden = true;
    if ([self.stDificultad integerValue] == 3) {
        self.buEliminarLetra.hidden = YES;
        self.buMostrarLetra.hidden = YES;
    }
    self.score = 0;
    [self jugar];
}

-(void) jugar{
    [self cargaImagen];
    unsigned long totalWords = self.diccionarioPalabras.count;
    self.stPalabraAAdivinar = [self seleccionaPalabraParaJuego:totalWords];
    _stPalabraAAdivinar = [_stPalabraAAdivinar lowercaseString];
    if([_stDificultad integerValue] != 3){
        for (UIButton *b in _arregloBotonesRespuesta) {
            [b removeFromSuperview];
        }
        for (UIButton *b in _arregloBotones) {
            [b removeFromSuperview];
        }
        [self initTiles];
    } else {
        _tfPalabraAdivinada.hidden = false;
        _tfPalabraAdivinada.text = @"";
    }
    
    [self cargaImagen];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) filtrarPalabrasDeDiccionario{
    unsigned long l = [self.diccionarioPalabras count];
    
    NSDictionary *temp;
    
    for(unsigned long i = 0 ; i < l ; i++){
        temp = [self.diccionarioPalabras objectAtIndex:i];
        if ([[temp objectForKey:@"idCat"] integerValue] != self.idCategoria) {
            [self.diccionarioPalabras removeObjectAtIndex:i];
            l = [self.diccionarioPalabras count];
            i--;
        }
    }
    
}
-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}
-(char *) generateRandomChar{
    char *c = (char*) malloc(sizeof(char) * 1);
    *c = (char) (arc4random_uniform(26) + 'a');
    return c;
}
-(NSString *) seleccionaPalabraParaJuego: (unsigned long) totalWords{
    
    self.indice =  [self getRandomNumberBetween:0 to:(int) totalWords - 1];
    return[[self.diccionarioPalabras objectAtIndex:self.indice] objectForKey:@"palabra"];
}

-(void) cargaImagen{
    
    NSString *stringUrl =[[self.diccionarioPalabras objectAtIndex:self.indice] objectForKey:@"imagen"];
    NSURL *nsurl = [NSURL URLWithString: stringUrl ];
    NSData *data = [[NSData alloc] initWithContentsOfURL: nsurl];
    self.imageView.image = [UIImage imageWithData: data];
}
-(void) randomCharBotton: (NSInteger) totalButton{
    
    NSInteger posRandom;
    int pos = 0;
    long lengthWord = self.stPalabraAAdivinar.length;
    UIButton *boton;
    char *tituloBoton;
    char *caracter;
    
    
    while(pos < lengthWord){
        
        // generar numero random de 0 a numero de botones
        posRandom = [self getRandomNumberBetween:0 to:(int)totalButton-1];
        // tomar el boton
        boton = [self.arregloBotones objectAtIndex:posRandom];
        // tomar titulo del boton
        tituloBoton = (char*) [boton.titleLabel.text UTF8String];
        
        // si el titulo es lo que se busca,
        if((*tituloBoton >= '0' ) && (*tituloBoton <= '9')){
            // se hace un substring de la palabra, tomando un caracter
            caracter = (char* ) [[self.stPalabraAAdivinar substringWithRange:NSMakeRange(pos,1)] UTF8String];
            [boton setTitle: [NSString stringWithFormat:@"%c",*caracter]  forState:UIControlStateNormal];
            } // de otro modo
        else{
            // se busca otro boton generando numeros random
            while(*tituloBoton <= '0'  && *tituloBoton >= '9'){
                posRandom = [self getRandomNumberBetween:0 to:(int)totalButton-1];
                boton = [self.arregloBotones objectAtIndex:posRandom];
                tituloBoton = (char*)[boton.titleLabel.text UTF8String];
            }
            caracter = (char* ) [[self.stPalabraAAdivinar substringWithRange:NSMakeRange(pos,1)] UTF8String];
            [boton setTitle: [NSString stringWithFormat:@"%c",*caracter]  forState:UIControlStateNormal];
        }
        
        pos++;
    }
    
    for(int j = 0; j < totalButton; j++){
        
        boton = [self.arregloBotones objectAtIndex:j];
        tituloBoton =(char*)[boton.titleLabel.text UTF8String];
        
        if((*tituloBoton >= '0' ) && (*tituloBoton <= '9')){
            caracter = [self generateRandomChar];
            [[self.arregloBotones objectAtIndex:j] setTitle: [NSString stringWithFormat:@"%c",*caracter]  forState:UIControlStateNormal];
        }
    }
    
}
-(void)initTiles
{
    NSInteger numberOfButtons = [self getNumberOfButtons:self.stPalabraAAdivinar];
    self.arregloBotones = [[NSMutableArray alloc] initWithCapacity:numberOfButtons];
    self.arregloBotonesRespuesta = [[NSMutableArray alloc] initWithCapacity:numberOfButtons];
    NSInteger buttonsInUpperRow = numberOfButtons / 2, buttonsInLowerRow = numberOfButtons - buttonsInUpperRow;
    
    
    for (int count = 0; count < buttonsInUpperRow; count++)
    {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, self.STARTINGY, self.BUTTONWIDTH, self.BUTTONHEIGHT)];
        [b setTitle:[NSString stringWithFormat:@"%i",count+1] forState:UIControlStateNormal];
        [b setTag:count];
        [b setHidden:NO];
        [b addTarget:self action:@selector(letraDeBancoPresionada:) forControlEvents:UIControlEventTouchUpInside];
        [b setBackgroundColor:[UIColor purpleColor]];
        [self.arregloBotones addObject:b];
        [self.view addSubview:b];
    }
    
    for (int count = 0; count < buttonsInLowerRow; count++)
    {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, self.STARTINGY + self.BUTTONHEIGHT + self.SPACEBETWEENBUTTONS, self.BUTTONWIDTH, self.BUTTONWIDTH)];
        [b setTitle:[NSString stringWithFormat:@"%d",count+1 + buttonsInUpperRow] forState:UIControlStateNormal];
        [b setTag:count];
        [b setHidden:NO];
        [b addTarget:self action:@selector(letraDeBancoPresionada:) forControlEvents:UIControlEventTouchUpInside];
        [b setBackgroundColor:[UIColor purpleColor]];
        [self.arregloBotones addObject:b];
        [self.view addSubview:b];
    }
    
    // Dibujo de botones superiores
    if(numberOfButtons != 0){
        for (int count = 0; count < self.stPalabraAAdivinar.length; count++)
        {
            UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, 250, self.BUTTONWIDTH, self.BUTTONHEIGHT)];
            [b setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
            [b setTag:count];
            [b setHidden:NO];
            [b addTarget:self action:@selector(letraDeRespuestaPresionada:) forControlEvents:UIControlEventTouchUpInside];
            [b setBackgroundColor:[UIColor blueColor]];
            [self.arregloBotonesRespuesta addObject:b];
            [self.view addSubview:b];
        }
    } else {
        self.tfPalabraAdivinada.hidden = false;
    }
    [self randomCharBotton:numberOfButtons];
}





- (IBAction)letraDeBancoPresionada:(id)sender {
    UIButton *button = (UIButton *) sender;
    
    if (button.isEnabled) {
        button.hidden = YES;
        NSString *buttonTitle = button.titleLabel.text;
        for(int i = 0 ; i < self.arregloBotonesRespuesta.count ; i++){
            UIButton* selectedButton = [self.arregloBotonesRespuesta objectAtIndex: i];
            if ([[selectedButton currentTitle] isEqualToString:@""]){
                [selectedButton setTitle:buttonTitle forState:UIControlStateNormal];
                [self.arregloBotonesRespuesta setObject:selectedButton atIndexedSubscript:i];
                break;
            }
        }
    }
    
    
}

- (IBAction)letraDeRespuestaPresionada:(id)sender{
    UIButton *button = (UIButton * ) sender;
    NSString *titulo = button.currentTitle;
    if (![titulo isEqualToString:@""]){
        for (UIButton *bu in self.arregloBotones){
            if (bu.isHidden){
                [bu setTitle:titulo forState:UIControlStateNormal];
                bu.hidden = false;
                break;
            }
        }
    }
    [button setTitle:@"" forState:UIControlStateNormal];
}



- (NSInteger) getNumberOfButtons: (NSString*) word{
    NSInteger val = [self.stDificultad integerValue];
    if(val == 1) {
        return word.length + 2;
    } else if (val ==2) {
        return word.length + 5;
    }
    return 0;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"segueFinal"]){
        FinalViewController*fvc = [segue destinationViewController];
        fvc.delegado = self.vc;
        NSString *wordCheck = @"";
        for (UIButton *bu in self.arregloBotonesRespuesta) {
            wordCheck = [NSString stringWithFormat:@"%@%@", wordCheck, bu.titleLabel.text];
        }
        fvc.resultadoJugada = [wordCheck isEqualToString:self.stPalabraAAdivinar];
        fvc.score2 = self.score;
    }
}



- (IBAction)bupEliminarLetra:(id)sender {
    NSString *helper = [NSString stringWithFormat:@"%@", self.stPalabraAAdivinar];
    NSRange r;
    for (int i = 0 ; i < self.arregloBotones.count ; i++){
        UIButton *bu = [self.arregloBotones objectAtIndex:i];
        if (helper.length == 0) {
            r.location = NSNotFound;
        } else {
            r = [helper rangeOfString:bu.currentTitle];
        }
        if (r.location == NSNotFound && !(bu.isHidden)) {
            bu.hidden = true;
            i--;
            break;
        } else if(r.location != NSNotFound){
            helper = [NSString stringWithFormat:@"%@%@", [helper substringWithRange:NSMakeRange(0, r.location)], [helper substringFromIndex:(r.length + r.location)]];
        }
    }
}

- (IBAction)bupMostrarLetra:(id)sender {
    int ctr = 0;
    
    for (UIButton *bu in self.arregloBotonesRespuesta){
        if (bu.isEnabled && ![[self.stPalabraAAdivinar substringWithRange:NSMakeRange(ctr, 1)] isEqualToString:bu.currentTitle]){
            [bu setTitle:
             [self.stPalabraAAdivinar substringWithRange:NSMakeRange(ctr, 1)] forState:UIControlStateNormal];
            bu.enabled = false;
            break;
        }
        ctr++;
    }
    
}


- (IBAction)botonPrueba:(id)sender {
    
    NSString *wordCheck = @"";
    if ([_stDificultad integerValue] != 3) {
        for (UIButton *bu in self.arregloBotonesRespuesta) {
            wordCheck = [NSString stringWithFormat:@"%@%@", wordCheck, bu.titleLabel.text];
        }
    } else {
        wordCheck = [_tfPalabraAdivinada.text lowercaseString];
        NSLog (@"'%@'\n'%@'", wordCheck, _stPalabraAAdivinar);
    }
    
    
    if([wordCheck isEqualToString:self.stPalabraAAdivinar]){
        self.score=self.score+1;
        [self jugar];
    }
    else{
        NSString *mensaje = [ [ NSString alloc ] initWithFormat: @"Intenta de nuevo"];
        UIAlertView *alerta = [ [ UIAlertView alloc ] initWithTitle: @"Palabra incorrecta" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerta show];
        
    }
    
    
}

@end
