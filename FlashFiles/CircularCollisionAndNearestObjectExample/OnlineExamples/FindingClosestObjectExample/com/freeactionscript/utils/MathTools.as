/**
 * Math Tools
 * ---------------------
 * VERSION: 1.0.0
 * DATE: 8/23/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript.utils 
{
	public class MathTools 
	{
		
		//////////////////////////////////////
		// Public API 
		//////////////////////////////////////
		
		/**
		 * Use this to get the distance between two points
		 * @param	delta_x
		 * @param	delta_y
		 * @return	Distance
		 */
		public static function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public static function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public static function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
		//////////////////////////////////////
		// Private Methods
		//////////////////////////////////////
		
		
	}

}