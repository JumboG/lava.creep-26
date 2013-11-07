//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import "ImageMove.h"

@implementation ImageMove

/*- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}*/


- (id) initWithImage:(UIImage *)image 
{
    if(self = [super initWithImage:image])
    {
        [self setUserInteractionEnabled:YES]; 
        [self setMultipleTouchEnabled:YES];
    } return self;
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        CGPoint newTouch = [[touches anyObject] locationInView:[self superview]]; 
        CGPoint lastTouch = [[touches anyObject] previousLocationInView: [self superview]];
        
        float xDif = newTouch.x - lastTouch.x; 
        float yDif = newTouch.y - lastTouch.y;
        CGAffineTransform translate = CGAffineTransformMakeTranslation(xDif, yDif);
        [self setTransform: CGAffineTransformConcat([self transform], translate)]; 
    } 
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
