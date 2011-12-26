#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <CAnn.mqh>
#include <CCalculate.mqh>

class CAnnManager
{
private:
   int annsNumber;
   CAnn* annsArray[];
   
public:
   CAnnManager(int annsNumber, int annInputNumber, string path, string prefix, CCalculate* calc) {
      string annPath;
      CAnn *ann;  
   
      annPath = path + prefix + "_";
         
      this.annsNumber = annsNumber;
      
      // Initialize anns
      ArrayResize (annsArray, annsNumber);
       
      for (int i = 0; i < annsNumber; i++) {
         if (i % 2 == 0) {
            ann = new CAnn(annInputNumber, annPath + "." + i + "-long.net");
         } else {
            ann = new CAnn(annInputNumber, annPath + "." + i + "-short.net");
         }

         ann.setCalculate(calc);
         annsArray[i] = ann;
      }
   }
   
   ~CAnnManager() {
      for(int i=0; i<annsNumber; i++) {
         delete annsArray[i];
      }
   }
   
   void saveAll() {
      for(int i=0; i<annsNumber; i++) {
         annsArray[i].ann_save();
      }
   }
};