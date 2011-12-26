//+------------------------------------------------------------------+
//|                                                    NeuroMACD.mq5 |
//|                        Copyright 2011, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2011, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"

//#include <CAnn.mqh>
//
//CAnn a;

#include <AnnManager.mqh>
#include <CalculateMACD.mqh>

CCalculate *c;
CAnnManager *m;

void OnStart() 
{

   c = new CCalculateMACD();
   
   m = new CAnnManager(2, 3, "C:\\ANN\\", "test", c);
   
   m.saveAll();
   
   delete m;
   delete c;

}

