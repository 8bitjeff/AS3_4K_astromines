
package {

	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	

	public class Main extends Sprite {
		
		private var mode:int = 0;
		private var shiphit:Boolean;
		private var aShipAnimation:Array = [];
		private var aShipAnimation2:Array = [];
		private var PO:Object = { };
		private var missileBD:BitmapData; 
		private var redpartBD:BitmapData;
		private var yellowpartBD:BitmapData;
		private var canvasBD:BitmapData = new BitmapData(800, 800, false, 0x000000);
		private var appBackBD:BitmapData = new BitmapData(600, 400, false, 0x000000);
		private var appBitmap:Bitmap = new Bitmap(appBackBD);
		private var viewBD:BitmapData=new BitmapData(400, 400, false, 0x000000);
		private var viewBitmap:Bitmap = viewBitmap=new Bitmap(viewBD);
		private var backgroundBD:BitmapData=new BitmapData(800,800,false,0x000000);
		private var point00:Point = new Point();
		private var playerPoint:Point=new Point();
		private var rect16:Rectangle = new Rectangle(0,0,16,16);
		private var aKeyPress:Array=[];
		private var aAsteroidAnimation:Array;
		private var aRock:Array;
		private var rockPoint:Point=new Point();
		private var aMissile:Array; 
		private var missilePoint:Point=new Point();
		private var lastMissileShot:int = 0;
		private var missileCtr:int;
		private var tempMissile:Object;
		private var tempRock:Object;
		private var rockCtr:int;
		private var aActiveParticle:Array;
		private var explodeCtr:int;
		private var tempPart:Object;
		private var partCtr:int;
		private var partPoint:Point=new Point();
		private var randInt:int;
		private var ctr:int;
		private var sBD:BitmapData = new BitmapData(16, 16, true, 0xff000000);
		private var sBD2:BitmapData = new BitmapData(16, 16, true, 0xff000000);
		private var aCR:Array = [0x0066ff, 0xff3366,0xffff00 ];
		private var eBD:BitmapData = new BitmapData(16, 16, true, 0xff000000);
		private var viewXOffset:Number=0;
		private var viewYOffset:Number = 0;
		private var viewRect:Rectangle = new Rectangle(0, 0, 400, 400);
		private var radarBitmap:Bitmap = new Bitmap(canvasBD);
		private var level:int;
		private var score:int;
		private var ltext:TextField = new TextField();
		private var stext:TextField = new  TextField();
		private var llabel:TextField = new TextField();
		private var slabel:TextField = new TextField();
		private var mlabel:TextField = new TextField();
		private var rlabel:TextField = new TextField();
		private var rformat:TextFormat = new TextFormat("_sans","16","0xffffff","true");
		private var drawCanvas:Shape = new Shape();
		private var gf:GlowFilter = new GlowFilter(0x0066ff, 1, 3 , 3, 3, 3, false, false);
		
		public function Main() {
			addChild(appBitmap);
			
			
			for (ctr = 0; ctr < 800; ctr ++) {
				randInt = int(Math.random() * 799);
				var randInt2:int=int(Math.random() * 799);
				backgroundBD.setPixel32(randInt, randInt2, aCR[0]);
			}
			rformat.align = "center";
			
			
			
			
			
			
			
			drawCanvas.filters = [gf];
			drawCanvas.graphics.lineStyle(4,aCR[3]);
			drawCanvas.graphics.drawRect(5, 5, 790, 790);
			backgroundBD.draw(drawCanvas);
			drawCanvas.graphics.clear();
			//drawCanvas.graphics.lineStyle(2, aCR[3]);
			//drawCanvas.graphics.moveTo(400, 0);
			//drawCanvas.graphics.lineTo(400, 399);
			drawCanvas.graphics.lineStyle(2, 0xffffff);
			drawCanvas.graphics.moveTo(460, 50);
			drawCanvas.graphics.lineTo(460, 25);
			drawCanvas.graphics.lineTo(472, 37);
			drawCanvas.graphics.lineTo(485, 25);
			drawCanvas.graphics.lineTo(485, 50);
			drawCanvas.graphics.moveTo(495, 37);
			drawCanvas.graphics.lineTo(515, 37);
			drawCanvas.graphics.moveTo(520, 25);
			drawCanvas.graphics.lineTo(545, 50);
			drawCanvas.graphics.moveTo(545, 25);
			drawCanvas.graphics.lineTo(520, 50);
			appBackBD.draw(drawCanvas);
			
			drawCanvas.graphics.clear();
			drawCanvas.graphics.lineStyle(2, 0xffffff);
			drawCanvas.graphics.moveTo(7, 1);
			drawCanvas.graphics.lineTo(1, 14);
			drawCanvas.graphics.lineTo(7, 7);
			drawCanvas.graphics.moveTo(8, 7);
			drawCanvas.graphics.lineTo(14, 14);
			drawCanvas.graphics.lineTo(8, 1);
			sBD.draw(drawCanvas);
			sBD.applyFilter(sBD, sBD.rect, point00, gf);
			drawCanvas.graphics.lineStyle(2,aCR[1]);
			drawCanvas.graphics.moveTo(7, 11);
			drawCanvas.graphics.lineTo(7, 13);
			drawCanvas.graphics.moveTo(8, 11);
			drawCanvas.graphics.lineTo(8, 13);
			sBD2.draw(drawCanvas);
			sBD2.applyFilter(sBD2, sBD2.rect, point00, gf);
			
			radarBitmap.x = 420;
			radarBitmap.y = 200;
			radarBitmap.scaleX = .2;
			radarBitmap.scaleY = .2;
			
			PO.acceleration=.3;
			PO.maxVelocity = 8;
			
			
			slabel.defaultTextFormat = rformat;
			slabel.filters = [gf];
			llabel.defaultTextFormat = rformat;
			llabel.filters = [gf];
			stext.defaultTextFormat = rformat;
			stext.filters = [gf];
			ltext.defaultTextFormat = rformat;
			ltext.filters = [gf];
			mlabel.defaultTextFormat=rformat;
			mlabel.filters = [gf];
			rlabel.defaultTextFormat = rformat;
			rlabel.filters = [gf];
			
			addChild(viewBitmap);
			addChild(radarBitmap);
			addChild(llabel);
			addChild(slabel); 
			addChild(ltext);
			addChild(stext);
			mlabel.text = "MINE-X 4K\n\nHIT SPACE";
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpListener);
			addEventListener(Event.ENTER_FRAME, runGame);
			viewBitmap.filters = [new GlowFilter(0x0066ff, .5, 400, 400, 1, 1, true, false)];
			 
			
		}
	
		private function runGame(e:Event):void {
			
			switch (mode) {
				
				case 0:
					shiphit = false;
					aRock = [];
					aActiveParticle = [];
					aMissile = [];
					level = 0;
					score = 0;
					mlabel.x = 160;
					mlabel.y = 180;
					llabel.text = "LVL";
					slabel.text = "1UP";
					llabel.x = 400;
					slabel.x = 400;
					llabel.y = 75;
					ltext.y = 75;
					ltext.x = 440;
					stext.x = 440;
					slabel.y = 100;
					stext.y = 100;
					rlabel.text = "RADAR";
					rlabel.x = 450;
					rlabel.y = 175;
					addChild(mlabel);
					addChild(rlabel);
					mode = 1;
					break;
				case 1:
					if (aKeyPress[32]) {
						removeChild(mlabel);
						mode = 2;
					}
				
					break;
				case 2:
					drawCanvas.filters = [];
					level++;
					(level % 2==0)? aCR[2] =0x00ffff :aCR[2] = 0xffff00;
					ltext.text = level.toString();
					stext.text = "0";
					
					gf.quality = 7;
					gf.strength = 7;
					gf.color = aCR[1];
					redpartBD= new BitmapData(10, 10, true, 0x00000000);
					redpartBD.setPixel32(4, 4, 0xffffffff);
					redpartBD.setPixel32(4, 5, 0xffffffff);
					redpartBD.setPixel32(5, 4, 0xffffffff);
					redpartBD.setPixel32(5, 5, 0xffffffff);
					missileBD = redpartBD.clone();
					yellowpartBD = redpartBD.clone();
					redpartBD.applyFilter(redpartBD, missileBD.rect, point00, gf);
			
					gf.color = aCR[2];
					yellowpartBD.applyFilter(yellowpartBD, missileBD.rect, point00, gf);
					gf.color = aCR[0];
					missileBD.applyFilter(missileBD, missileBD.rect, point00, gf);
					
					
					drawCanvas.graphics.clear();
					drawCanvas.graphics.lineStyle(2, aCR[1]);
					drawCanvas.graphics.drawRect(2, 2, 12, 12);
					drawCanvas.graphics.lineStyle(2, aCR[2]);
					drawCanvas.graphics.drawRect(4, 4, 8, 8);
					drawCanvas.graphics.drawRect(4, 4, 8, 8);
					
					eBD.draw(drawCanvas);

					
					
					aAsteroidAnimation = [];
					var rotation:int=0; 
					while (rotation<360){
						var angle_in_radians:Number = Math.PI * 2 * (rotation / 360);
						var rotationMatrix:Matrix = new Matrix();
						rotationMatrix.translate(-8,-8);
						rotationMatrix.rotate(angle_in_radians);
						rotationMatrix.translate(8,8);
						var matrixImageShip:BitmapData = new BitmapData(16, 16, true, 0x00000000);
						var matrixImageShip2:BitmapData = new BitmapData(16, 16, true, 0x00000000);
						var matrixImageAsteroid:BitmapData = new BitmapData(16, 16, true, 0x00000000);
						matrixImageShip.draw(sBD, rotationMatrix);
						matrixImageShip2.draw(sBD2, rotationMatrix);
						matrixImageAsteroid.draw(eBD, rotationMatrix);
						aAsteroidAnimation.push(matrixImageAsteroid);
						aShipAnimation.push(matrixImageShip);
						aShipAnimation2.push(matrixImageShip2);
						rotation+=10;
					}
					
					PO.x=400;
					PO.y=400;
					PO.dx=0;
					PO.dy=0;
					PO.movex=0;
					PO.movey = 0;
					PO.array = aShipAnimation;
					PO.arrayIndex = 0;
					PO.bitmapData = PO.array[PO.arrayIndex];
					
					
					for (ctr=0;ctr<15+5*level;ctr++) {
						tempRock={}; 
						randInt=int(Math.random()*35);
						tempRock.dx=Math.cos(2.0*Math.PI*((randInt*10)-90)/360.0);
						tempRock.dy = Math.sin(2.0 * Math.PI * ((randInt * 10) - 90) / 360.0);
						(level % 2==0)? tempRock.y = 700 : tempRock.y = 100;
						tempRock.x = 100;
						tempRock.animationIndex=0 ;
						tempRock.bitmapData=aAsteroidAnimation[0];
						tempRock.speed = (Math.random()*1)+3+level;
						aRock.push(tempRock);
					}
					
					mode = 3;
					break;
				
					case 3:
						canvasBD.copyPixels(backgroundBD, backgroundBD.rect, point00);
						if (!shiphit) {
							if (aKeyPress[38]) {
								PO.array = aShipAnimation2;
								PO.dx=Math.cos(2.0*Math.PI*((PO.arrayIndex*10)-90)/360.0);
								PO.dy=Math.sin(2.0*Math.PI*((PO.arrayIndex*10)-90)/360.0);
								
								var mxn:Number=PO.movex+PO.acceleration*(PO.dx);
								var myn:Number=PO.movey+PO.acceleration*(PO.dy);
							
								var currentSpeed:Number = Math.sqrt ((mxn*mxn) + (myn*myn));
								if (currentSpeed < PO.maxVelocity) {
									PO.movex=mxn;
									PO.movey=myn;
								} 
								
								
							}else {
								PO.array = aShipAnimation;
							}
							if (aKeyPress[37]){
								PO.arrayIndex--;
								if (PO.arrayIndex <0) PO.arrayIndex=35;
								PO.bitmapData=PO.array[PO.arrayIndex];
								
							}
							if (aKeyPress[39]){
								PO.arrayIndex++;
								if (PO.arrayIndex >35) PO.arrayIndex=0;
								PO.bitmapData=PO.array[PO.arrayIndex];
								
							}
							if (aKeyPress[32]){
								if (lastMissileShot > 2) {
									tempMissile={};
									tempMissile.x = PO.x + 3;
									tempMissile.y=PO.y+3;
									tempMissile.dx=Math.cos(2.0*Math.PI*((PO.arrayIndex*10)-90)/360.0);
									tempMissile.dy=Math.sin(2.0*Math.PI*((PO.arrayIndex*10)-90)/360.0);
									//tempMissile.bitmapData = new BitmapData(3, 3, false, 0x00ff00);
									tempMissile.bitmapData = missileBD;
									aMissile.push(tempMissile);
									lastMissileShot=0;
								}else {
									lastMissileShot++;
								}
								
							}
						
				
							PO.x+=(PO.movex);
							PO.y += (PO.movey);
							
							viewXOffset=PO.x-200;
							viewYOffset = PO.y - 200;
							if (viewXOffset < 0) viewXOffset = 0;
							if (viewYOffset < 0) viewYOffset = 0;
							if (viewXOffset > 399) viewXOffset = 399;
							if (viewYOffset > 399) viewYOffset = 399;
										
							
							
							if (PO.x+8 > 787 || PO.x+8 < 13 ) {
								PO.movex *= -1;
							}
							if (PO.y+8 > 787 || PO.y+8 < 13 ) {
								PO.movey *= -1;
							}
							playerPoint.x=PO.x;
							playerPoint.y = PO.y;
							canvasBD.copyPixels(PO.array[PO.arrayIndex], rect16, playerPoint);

						}	
							for each (tempRock in aRock) {
								tempRock.x+=tempRock.dx*tempRock.speed;
								tempRock.y+=tempRock.dy*tempRock.speed;
								
								if (tempRock.x > 787 || tempRock.x < 13) {
									tempRock.dx *= -1;
								}
								if (tempRock.y > 787 || tempRock.y < 13) {
									tempRock.dy *= -1;
								}
								rockPoint.x=tempRock.x;
								rockPoint.y=tempRock.y;
								canvasBD.copyPixels(aAsteroidAnimation[tempRock.animationIndex], rect16, rockPoint);
								tempRock.animationIndex++;
								if (tempRock.animationIndex > 35) {
									tempRock.animationIndex = 0;
								}
								tempRock.bitmapData=aAsteroidAnimation[tempRock.animationIndex];
							}
						
							for (ctr=aMissile.length-1;ctr>=0;ctr--) {
								tempMissile=aMissile[ctr];
								tempMissile.x+=tempMissile.dx*6;
								tempMissile.y+=tempMissile.dy*6;
								
								if (tempMissile.x > 799 || tempMissile.x < 0 || tempMissile.y > 799 || tempMissile.y < 0 ) {
									aMissile.splice(ctr,1);
									tempMissile=null;
								}else {
									missilePoint.x=tempMissile.x;
									missilePoint.y=tempMissile.y;
									canvasBD.copyPixels(tempMissile.bitmapData,tempMissile.bitmapData.rect, missilePoint);
								}
								
								
							}
					
							for (partCtr=aActiveParticle.length-1;partCtr>=0;partCtr--) {
								tempPart=aActiveParticle[partCtr];
								tempPart.x+=tempPart.dx*tempPart.speed;;
								tempPart.y+=tempPart.dy*tempPart.speed;
								
								
								tempPart.lifeCount++;
								if (tempPart.lifeCount > tempPart.life) {
									aActiveParticle.splice(partCtr,1);  
								}else {
									partPoint.x=tempPart.x;
									partPoint.y=tempPart.y;
									canvasBD.copyPixels(tempPart.bitmapData,tempPart.bitmapData.rect, partPoint);
								}
							
								
								
							}
							viewRect.x = viewXOffset;
							viewRect.y = viewYOffset;
							viewBD.copyPixels(canvasBD, viewRect, point00);
							
						
							rocks: for (rockCtr = aRock.length-1; rockCtr >= 0; rockCtr--) {

								tempRock=aRock[rockCtr];
								rockPoint.x=tempRock.x;
								rockPoint.y=tempRock.y;
								missiles: for (missileCtr=aMissile.length-1;missileCtr>=0;missileCtr--) {
									tempMissile=aMissile[missileCtr];
									missilePoint.x=tempMissile.x;
									missilePoint.y=tempMissile.y;
									
								
										if (tempMissile.bitmapData.hitTest(missilePoint,255,tempRock.bitmapData,rockPoint,255)) {
											createExplode(tempRock.x+8,tempRock.y+8,1);
											tempMissile=null;
											tempRock=null;
											aMissile.splice(missileCtr,1);
											aRock.splice(rockCtr, 1);
											score += 5 * level;
											stext.text = score.toString();
											
											break rocks;
											break missiles;
											
										}
								
								}
								
								playerPoint.x=PO.x;
								playerPoint.y=PO.y;
								
									if (tempRock.bitmapData.hitTest(rockPoint,255,PO.bitmapData,playerPoint,255) &&!shiphit){

										createExplode(tempRock.x+18,tempRock.y+18,1);
										tempRock=null;
										aRock.splice(rockCtr, 1);
										shiphit = true;
										createExplode(PO.x + 8, PO.y + 8, 2);
										mlabel.text = "GAME OVER\n\nHIT SPACE";
									}
								
							}
							if (aRock.length == 0 && aActiveParticle.length == 0) mode = 2;
							if ( aActiveParticle.length == 0 && shiphit) mode = 0;	
							
										
						break;
					
					
						
			}
			
			
			
		}
		
		
		
		private function keyDownListener(e:KeyboardEvent):void {
			aKeyPress[e.keyCode]=true;
			
		}
		
		private function keyUpListener(e:KeyboardEvent):void {
			aKeyPress[e.keyCode]=false;
		}
				
		
		private function createExplode(xval:Number,yval:Number,type:int):void {
			for (explodeCtr=0;explodeCtr<40;explodeCtr++) {
					tempPart = {};
					tempPart.lifeCount=0;
					tempPart.x=xval;
					tempPart.y=yval;
					tempPart.speed = (Math.random() * 3) + 1;
					//tempPart.bitmapData = new BitmapData(2, 2, false,((type ==1)?((explodeCtr % 2 ==0) ? aCR[1]: aCR[2]):aCR[3]) );
					//tempPart.bitmapData = new BitmapData(2, 2, false,  aCR[ explodeCtr & 1 + 1 + type] );
					//(type ==1)?tempPart.bitmapData = redpartBD: tempPart.bitmapData = missileBD;
					tempPart.bitmapData = ((type == 1)?((explodeCtr % 2 == 0) ? yellowpartBD: redpartBD):missileBD ) ;
					randInt=int(Math.random()*36);
					tempPart.dx=Math.cos(2.0*Math.PI*((randInt*10)-90)/360.0);
					tempPart.dy = Math.sin(2.0 * Math.PI * ((randInt * 10) - 90) / 360.0);
					tempPart.life = 50 + randInt;
					aActiveParticle.push(tempPart);
					
			
				
			}
			
		}
		
		
		
	}
	
}