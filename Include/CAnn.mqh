#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <Fann2MQL.mqh>

class CAnn {

   private:
      int ann;
      int debugLevel;
      int annInputs;
      string path;
      

   public:

   CAnn(int annInputNumber, string sPath) {
      ann = -1;
      debugLevel = 2;
      annInputs = annInputNumber;
      path = sPath;
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
   ann_load ()
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
   
   void
   ann_save ()
   {
       int ret = -1;
       ret = f2M_save (ann, path);
       debug (1, "f2M_save(" + ann + ", " + path + ") returned: " + ret);
   }

   void
   ann_destroy ()
   {
       int ret = -1;
       ret = f2M_destroy (ann);
       debug (1, "f2M_destroy(" + ann + ") returned: " + ret);
   }

   double
   ann_run (double &vector[])
   {
      int ret;
      double out;

      ret = f2M_run (ann, vector);
      if (ret < 0) {
         debug (0, "Network RUN ERROR! ann=" + ann);
         return (FANN_DOUBLE_ERROR);
      }
      out = f2M_get_output (ann, 0);
      debug (3, "f2M_get_output(" + ann + ") returned: " + out);
      return (out);
   }

   void setCalculate() {
      
   }

   void
   ann_prepare_input ()
   la{
   int i;
   
   for (i = 0; i <= AnnInputs - 1; i = i + 3) {
   InputVector[i] =
   10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE,
   MODE_MAIN, i * 3);
   InputVector[i + 1] =
   10 * iMACD (NULL, 0, FastMA, SlowMA, SignalMA, PRICE_CLOSE,
   MODE_SIGNAL, i * 3);
   InputVector[i + 2] = InputVector[i - 2] - InputVector[i - 1];
   }
   }



};
