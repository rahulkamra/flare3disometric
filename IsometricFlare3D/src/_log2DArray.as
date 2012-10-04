package 
{
	
	public function _log2DArray(array:Array,property:String = null):void{
		//check weather the array is 2D or not
		if(array == null){
			trace(this,"log2DArray","Array cannot be null");
			return;
		}
		
		var str:String = str + "\n";
		for(var count:int = 0 ; count < array.length ; count ++){
			var eachArray:Array = array[count] as Array;
			if(eachArray == null){
				trace(this,"log2DArray","Not a 2D Array");
				return;
			}
			
			for(var innerCount:int = 0 ; innerCount < eachArray.length ; innerCount++){
				if (property)
					str = str+array[count][innerCount][property] + "   ";
				else
					str = str+array[count][innerCount] + "   ";
						
			}
				
			str= str + "\n"
		}
		
		trace(this,"log2DArray",str);
	}
	
	
}