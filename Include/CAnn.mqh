#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <Fann2MQL.mqh>

class CAnn {

   private:
      int ann;
      int debugLevel;
      int annInputs;

   public:

   CAnn(int annInputNumber) {
      ann = -1;
      debugLevel = 2;
      annInputs = annInputNumber;
   }

   /**
   * Вывод отладочной информации
   */
   void
   debug (int level, string text)
   {
      if (debugLevel >= level) {
         if (level == 0)
            text = "ERROR: " + text;
         Print (text);
      }
   }

   bool
   ann_load (string path)
   {
       /* Load the ANN */
       ann = f2M_create_from_file (path);
       if (ann != -1) {
      	debug (1, "ANN: '" + path + "' loaded successfully with handler " + (string)ann);
       }
       else { /* Create ANN */
      	ann = f2M_create_standard (4, annInputs, annInputs, annInputs / 2 + 1, 1);
      	f2M_set_act_function_hidden (ann, FANN_SIGMOID_SYMMETRIC_STEPWISE);
      	f2M_set_act_function_output (ann, FANN_SIGMOID_SYMMETRIC_STEPWISE);
      	f2M_randomize_weights (ann, -0.4, 0.4);
      	debug (1, "ANN: '" + path + "' created successfully with handler " + (string)ann);
       }
       if (ann == -1) {
      	debug (0, "ERROR INITIALIZING NETWORK!");
      	return(false);
       } else {
         return(true);
       }
   }

};
