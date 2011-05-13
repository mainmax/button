package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import flash.display.BlendMode;
	import flash.display.Shape;
	
	import flash.display.BitmapData; 
	import flash.display.DisplayObject; 
	
	import flash.geom.*;
	import flash.filters.*;
	
	import mx.graphics.codec.JPEGEncoder;
	
	
	/**
	 * ...
	 * @author MAX
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = "noScale";
			var camera:Camera = Camera.getCamera();			
			camera.setMode(2592,1944, 10);
//			camera.setMode(640,480, 10);
			camera.setQuality(0, 100);
			var video:Video = new Video(camera.width/8, camera.height/8);
//			var video:Video = new Video(camera.width, camera.height);
			video.attachCamera(camera);
			//video.x = 100;
			addChild(video);

			var video2:Video = new Video(camera.width, camera.height);
			video2.attachCamera(camera);
			var screenS:BitmapData = new BitmapData(camera.width, camera.height, true,0xff000000); 
			var screenS_image:Bitmap= new Bitmap(screenS); 
			addChild(screenS_image);
			screenS_image.x = video.x + video.width;
			screenS_image.width = video.width;
			screenS_image.height = video.height;
			
			
			stage.addEventListener(MouseEvent.CLICK, takephoto); 
			function takephoto(e:MouseEvent):void { 
//				var file:FileReference = new FileReference();
//				screenS.draw(video);
//				var jpg:JPEGEncoder = new JPEGEncoder(80);
//				var ba:ByteArray = jpg.encode(screenS);
//				file.save(ba,'test.jpg');
				 


				screenS.draw(video2);
				var co:Number =2;
				screenS.colorTransform(new Rectangle(0, 0, screenS.width, screenS.height), new ColorTransform(co, co, co, 1) );

				var ca:Number = 2;
				var cb:Number = -128;
				//redValue = greenValue = blueValue = ca;
				//redOffset = greenOffset = blueOffset = cb;
				var cmf:ColorMatrixFilter = new ColorMatrixFilter(new Array(ca, 0, 0, 0, cb, 0, ca, 0, 0, cb, 0, 0, ca, 0, cb, 0, 0, 0, 1, 0));
				screenS.applyFilter(screenS, new Rectangle(0, 0, screenS.width, screenS.height), new Point(0,0), cmf);
				
				
				var filter2:BlurFilter = new BlurFilter();
				//screenS.applyFilter(screenS, new Rectangle(0, 0, screenS.width, screenS.height), new Point(0,0), filter2);				
				
				// Variables that affect clamping:
				var clamp:Boolean = false;
				var clampColor:Number = 0xFF0000;
				var clampAlpha:Number = 1;
		        // For illustration, keep other ConvolutionFilter variables neutral:
				var bias:Number = 0;
				var preserveAlpha:Boolean = false;
				// Also, construct a neutral matrix
				var matrixCols:Number = 3;
				var matrixRows:Number = 3;
				// Sharpness
				var matrix:Array = [-2, -2, -2,
                               -2, 24, -2,
                              -2, -2, -2];
				// Outline
//	            var matrix:Array = [-30, 30, 0,
//                                -30, 30, 0,
//                                -30, 30, 10];
				var filter:ConvolutionFilter = new ConvolutionFilter(matrixCols, matrixRows, matrix, 8, bias, preserveAlpha, clamp, clampColor, clampAlpha);
				//screenS.applyFilter(screenS, new Rectangle(0, 0, screenS.width, screenS.height), new Point(0,0), filter);



/*
			//Create the Color histogram holder 
			var rholder:Sprite = new Sprite();
			 var gholder:Sprite = new Sprite();
			 var bholder:Sprite = new Sprite();
			 addChild(rholder);
			 addChild(gholder);
			 addChild(bholder);
			 //rholder.blendMode = BlendMode.SCREEN;
			 //gholder.blendMode = BlendMode.SCREEN;
			 //bholder.blendMode = BlendMode.SCREEN;
			 rholder.x = 100;
			 gholder.x = 100;
			 bholder.x = 100;
			 rholder.y = 400;
			 gholder.y = 400;
			 bholder.y = 400;
			 rholder.graphics.beginFill(0xFFCC00);
			 rholder.graphics.drawCircle(40, 40, 40);
			 
			 
			 //Create the Array Data holders 
			 var rArray:Array = new Array();
			 var gArray:Array = new Array();
			 var bArray:Array = new Array();
			 //Create Iterators 
			 var i:int = 0;
			 var j:int = 300;
			 //zero out the data 
			 for (i; i < 255; i++){
				rArray[i] = 0;
				gArray[i] = 0;
				bArray[i] = 0;
			 } i = 0;
			 //Get the image from the lib 
			 var bmd:BitmapData = new BitmapData(camera.width, camera.height, true);
			 //Get the Data from the image 
			 bmd.draw(video);
			 var total = bmd.width * bmd.height;
			 for(i; i < bmd.width; i++){     
				for(j; j < bmd.height; j++){
					var color:uint = bmd.getPixel(i,j);
					var r:uint = color >> 16;
					var g:uint = color >> 8 & 0xFF;
					var b:uint = color & 0xFF;
					var rD:int;
					var gD:int;
					var bD:int;
					 if(r >= 0){ rD = 1; }else{	rD = 0; }                 
					 if(g >= 0){ gD = 1; }else{	gD = 0; }                 
					 if(b >= 0){ bD = 1; }else{	bD = 0; }                 
					 rArray[r] += rD;
					 gArray[g] += gD;
					 bArray[b] += bD;
				 }     
				 j = 0;
			 } 
			 //Draw out Histograms 
			 for(i = 0; i < 255; i++){     
				var rline:Shape = new Shape();
				rholder.addChild(rline);
				rline.x = i;
				rline.graphics.lineStyle(.25, 0xffff0000);
				rline.graphics.lineTo(0, -(rArray[i] / 100));
				var gline:Shape = new Shape();
				gholder.addChild(gline);
				gline.x = i;
				gline.graphics.lineStyle(.25, 0xff00ff00);
				gline.graphics.lineTo(0, -(gArray[i] / 100));
				var bline:Shape = new Shape();
				bholder.addChild(bline);
				bline.x = i;
				bline.graphics.lineStyle(.25, 0xff0000ff);
				bline.graphics.lineTo(0, -(bArray[i] /  100));
			  }

*/





				} 
			
			
			}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}
