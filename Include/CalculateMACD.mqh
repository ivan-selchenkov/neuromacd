#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <CCalculate.mqh>

class CCalculateMACD : public CCalculate
{
   private:
      int annInputs = 9;

      int fastMA = 18;
      int slowMA = 36;
      int signalMA = 21;

      double MACDBuffer[];
      double SignalBuffer[];
      
      int iMacdHandle;

   public:
         CCalculateMACD();
         void calculate (int AnnInputs, double &inputVector[]);
         virtual int getInputsNumber() { return annInputs; };
};

CCalculateMACD::CCalculateMACD() {
   SetIndexBuffer(0,MACDBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,SignalBuffer,INDICATOR_DATA);
   
   iMacdHandle = iMACD(
      NULL,              // ��� �������
      0,              // ������
      fastMA,     // ������ ������� �������
      slowMA,     // ������ ��������� �������
      signalMA,       // ������ ���������� ��������
      PRICE_CLOSE  // ��� ���� ��� handle
   );   
}

void CCalculateMACD::calculate(double &inputVector[]) {
   int i;
   int ret;

   ret = CopyBuffer(
      iMacdHandle,     // handle ����������
      0,           // ����� ������ ����������
      1,            // ��������� ��������
      5,                // ������� �������� 1,2,3,4,5
      MACDBuffer             // ������, ���� ����� ����������� ������
   );

   ret = CopyBuffer(
      iMacdHandle,     // handle ����������
      1,           // ����� ������ ����������
      1,            // ��������� ��������
      5,                // ������� �������� 1,2,3,4,5
      SignalBuffer             // ������, ���� ����� ����������� ������
   );

   for (i = 0; i < annInputs; i = i + 3) {
      inputVector[i] = 10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE, MODE_MAIN, i * 3);
      inputVector[i + 1] = 10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE, MODE_SIGNAL, i * 3);
      inputVector[i + 2] = inputVector[i - 2] - inputVector[i - 1];
   }
}
