package com.talk.hash;


public class HashManager {

	public static String generateHashCode( String input )
	{
		long retval = 7723;
		
		for( int i = 0 ; i < input.length() ; i++ )
		{
			retval += retval*7919 + (int)input.charAt(i);
		}
			
		String temp = Long.toString(retval);
		
		String newtemp = "";
		
		for( int i = temp.length()-1 ; i >= (temp.length()-1)/2 ; i-- )
		{
			newtemp += temp.charAt(i) + temp.charAt(temp.length() - 1 -i);
		}
		
		System.out.println( newtemp );
		
		return newtemp;
	}
	
}