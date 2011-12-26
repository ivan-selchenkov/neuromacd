#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <CCalculate.mqh>

class CCalculateMACD : public CCalculate
{
   public:
         void calculate (int AnnInputs, double &inputVector[]);
};

void CCalculateMACD::calculate(int AnnInputs, double &inputVector[]) {
//   int i;
//   
//   for (i = 0; i <= AnnInputs - 1; i = i + 3) {
//      inputVector[i] = 10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE, MODE_MAIN, i * 3);
//      inputVector[i + 1] = 10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE, MODE_SIGNAL, i * 3);
//      inputVector[i + 2] = inputVector[i - 2] - inputVector[i - 1];
//   }
}
