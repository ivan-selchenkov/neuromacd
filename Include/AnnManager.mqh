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
   CAnnManager(int annsNumber, string path, string prefix, CCalculate* calc) {
      string annPath;
      CAnn *ann;  
   
      annPath = path + prefix + "_";
         
      this.annsNumber = annsNumber;
      
      // Initialize anns
      ArrayResize (annsArray, annsNumber);
       
      for (int i = 0; i < annsNumber; i++) {
         if (i % 2 == 0) {
            ann = new CAnn(annPath + "." + i + "-long.net", calc);
         } else {
            ann = new CAnn(annPath + "." + i + "-short.net", calc);
         }

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
   
   double wiseLong()
   {
      int i;
      double ret;
      
      if (annsNumber < 1)
         return (-1);
      
      for (i = 0; i < annsNumber; i += 2) {
         ret += annsArray[i].ann_run();
      }
      
      ret = 2 * ret / annsNumber;
      
      debug (3, "Wise long: " + ret);
      return (ret);
   }
   
};