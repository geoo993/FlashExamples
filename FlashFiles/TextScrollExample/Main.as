﻿package 
			textt = "I would like to scroll.";
			
			//Rectangle at x, y, width, height
			fBoxx.scrollRect = new Rectangle(0,0,200,20);
			fBoxx.newT.x -= 2;
			fBoxx.newT.text = textt;
			
			if (Math.abs(fBoxx.newT.x) >= fBoxx.newT.width)
			{
				fBoxx.newT.x = 200;
			}