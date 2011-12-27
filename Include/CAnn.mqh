#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <Fann2MQL.mqh>
#include <CCalculate.mqh>

class CAnn {

   private:
      int ann;
      int debugLevel;
      int annInputs;
      string path;
      CCalculate* calculator;
      double inputVector[];

   public:

   CAnn(string sPath, CCalculate* calc) {
      ann = -1;
      debugLevel = 2;
      annInputs = calc.getInputsNumber();
      path = sPath;

      this.calculator = calc;
      
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
       }
       if (ann == -1) {
      	debug (0, "ERROR INITIALIZING NETWORK!");
       } else {
         debug (1, "ANN: '" + path + "' created successfully with handler " + (string)ann);
       }
       
       ArrayResize(inputVector, annInputs);
       
   }
   
   /**
   * Уничтожение нейросети
   */ 
   ~CAnn() {
      int ret;
      if(ann != -1) {      
         ret = f2M_destroy (ann);
         debug (1, "f2M_destroy(" + ann + ") returned: " + ret);
      }
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

   /**
   * Сохранение нейросети в файл
   */
   void
   ann_save ()
   {
       int ret = -1;
       ret = f2M_save (ann, path);
       debug (1, "f2M_save(" + ann + ", " + path + ") returned: " + ret);
   }

   /**
   * Запуск нейросети на входящих данных
   */
   double
   ann_run ()
   {
      int ret;
      double out;
      
      calculator.calculate(inputVector);     
      
      ret = f2M_run (ann, inputVector);
      
      if (ret < 0) {
         debug (0, "Network RUN ERROR! ann=" + ann);
         return (FANN_DOUBLE_ERROR);
      }
      out = f2M_get_output (ann, 0);
      debug (3, "f2M_get_output(" + ann + ") returned: " + out);
      return (out);
   }
   
   /**
   * Обучение нейросети на входных и выходных данных
   */
   void
   ann_train (double &input_vector[], double &output_vector[])
   {
      if (f2M_train (ann, input_vector, output_vector) == -1) {
         debug (0, "Network TRAIN ERROR! ann=" + ann);
      } else {
         debug (3, "ann_train(" + ann + ") succeded");
      }
   }

};
