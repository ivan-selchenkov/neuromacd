#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

class CCalculate {
   public:
      virtual void calculate (int AnnInputs, double &inputVector[]) {};
      virtual int getInputsNumber() { return 0; };
};