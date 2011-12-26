#property copyright "Copyright 2011, Ivan Selchenkov"
#property version   "1.00"

#include <Fann2MQL.mqh>
#include <CalculateMACD.mqh>

class CAnn {

   private:
      int ann;
      int debugLevel;
      int annInputs;
      string path;
      CCalculate* calculator;

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

   /**
   * Загрузка нейросети из файла или создание новой
   */
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
   * Уничтожение нейросети
   */ 
   void
   ann_destroy ()
   {
       int ret = -1;
       ret = f2M_destroy (ann);
       debug (1, "f2M_destroy(" + ann + ") returned: " + ret);
   }

   /**
   * Запуск нейросети на входящих данных
   */
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
   
   /**
   * Обучение нейросети на входных и выходных данных
   */
   void
   ann_train (double &input_vector[], double &output_vector[])
   {
      if (f2M_train (ann, input_vector, output_vector) == -1) {
         debug (0, "Network TRAIN ERROR! ann=" + ann);
      }
         debug (3, "ann_train(" + ann + ") succeded");
      }
   }


   void setCalculate(CCalculate* c) {
      this.calculator = c;
   }

   void ann_prepare_input() {
      double inputVector[];
      calculator.calculate(annInputs, inputVector);
   }

};
