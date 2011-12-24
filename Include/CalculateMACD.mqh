#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <CCalculate.mqh>

class CCalculateMACD : public CCalculate
{
   public:
         virtual void calculate() { Alert("Calculate"); };
};
