/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.Timer;

/**
 *
 * @author I067515
 */

import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;
import com.Product.ProductEntry.*;

public class FetchMail extends TimerTask {
    
     public static void main (String args[] ) {
    TimerTask fetchMail  = new FetchMail();
    reportDaily rD1 = new reportDaily();
    
    //perform the task once a day at 4 a.m., starting tomorrow morning
    //(other styles are possible as well)
    Timer timer = new Timer();
    timer.scheduleAtFixedRate(fetchMail, getTomorrowMorning4am(), fONCE_PER_DAY);
    rD1.getData();
  }

  /**
  * Implements TimerTask's abstract run method.
  */
  public void run(){
    //toy implementation
    System.out.println("Fetching mail...");
  }

  // PRIVATE ////

  //expressed in milliseconds
  private final static long fONCE_PER_DAY = 1000*60;

  private final static int fONE_DAY = 60*24;
  private final static int fFOUR_AM = 9;
  private final static int fZERO_MINUTES = 0;

  private static Date getTomorrowMorning4am(){
    Calendar tomorrow = new GregorianCalendar();
    tomorrow.add(Calendar.DATE, fONE_DAY);
    Calendar result = new GregorianCalendar(
      tomorrow.get(Calendar.YEAR),
      tomorrow.get(Calendar.MONTH),
      tomorrow.get(Calendar.DATE),
      fFOUR_AM,
      fZERO_MINUTES
    );
    return result.getTime();
  }
    
}
