package miniroom;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

import java.text.*;

public class UtilMgr {

	 public static String getContent(String comment){
        return br("", "<br/>", comment);
   }

  public static String br(String first, String brTag, String comment){
        StringBuffer buffer = new StringBuffer();
        StringTokenizer st = new StringTokenizer(comment, "\n");
        int count = st.countTokens();
        buffer.append(first);
        int i = 1;
         while(st.hasMoreTokens()){ 
           if(i==count){
             buffer.append(st.nextToken());
           }else{ 
             buffer.append(st.nextToken()+ brTag);
		   }
           i++;
         }
       return buffer.toString(); 
  } 

  public static String monFormat(String b){
         String won;
		 double bb = Double.parseDouble(b); 
		 won = NumberFormat.getIntegerInstance().format(bb);
		 return won;
  }
  public static String monFormat(int b){
         String won;
		 double bb = b;
		 won = NumberFormat.getIntegerInstance().format(bb);
		 return won;
  }
  public static String intFormat(int i){
         String s = String.valueOf(i);
		 return monFormat(s);		  
  }
 
  //2009. 9. 28
  public static String getDay(){
	  Date now = new Date();
	  DateFormat df = DateFormat.getDateInstance();
	  return df.format(now).toString();
  }
  
	public static int parseInt(HttpServletRequest request, 
			String name) {
		return Integer.parseInt(request.getParameter(name));
	}
	
	public static int parseInt(MultipartRequest multi, 
			String name) {
		return Integer.parseInt(multi.getParameter(name));
	}
	public static String phoneFormat(String phone) {
		String returnValue = "";
		for(int i = 0 ; i < phone.length(); i++) {
			returnValue += phone.charAt(i);
			if(i == 2 || i == 6) {
				returnValue += "-";
			}
		}
		return returnValue;
	}
	
	public static String[] setTimeRange(String timestamp) {
		String times[] = new String[2];
		String prev;
		String next;
		String date = timestamp.split(" ")[0];
		String time = timestamp.split(" ")[1];
		String allTime[] = time.split(":");
		String hour = allTime[0];
		String min = allTime[1];
		String sec = allTime[2];
		
		int prevMin = Integer.parseInt(min) - 3;
		int nextMin = Integer.parseInt(min) + 3;
		
		String prevTime = hour +":"+ Integer.toString(prevMin) +":"+sec;
		String nextTime = hour +":"+ Integer.toString(nextMin) +":"+ sec;
		prev = date + " " + prevTime;
		next = date + " " + nextTime;
		System.out.println(prev);
		System.out.println(next);
		times[0] = prev;
		times[1] = next;
		return times;
	}
	
	public static void main(String[] args) {
		setTimeRange("2024-10-02 11:33:35");
	}
}







