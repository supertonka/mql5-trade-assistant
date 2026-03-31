//+------------------------------------------------------------------+
//|                                      MQ5 Trade Assistant 1.0.mq5 |
//|                                                       Supertonka |
//|                         https://www.instagram.com/diamondlabs_fx |
//+------------------------------------------------------------------+
#property copyright "Supertonka"
#property link      "https://www.instagram.com/diamondlabs_fx"
#property version   "1.00"
#property strict

#include       <TA/Core/Globals.mqh>
#include       <TA/UI/PanelMain.mqh>
#include       <TA/Chart/ChartObjects.mqh>
#include       <TA/Chart/DragHandler.mqh>
#include       <TA/Trading/RiskCalc.mqh>

CPanelMain     Panel;
CChartObjects  ChartObj;
CDragHandler   Dragger;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   Panel.Create(0, "MQL Trade Assistant", 0, 40, 40);
   ChartObj.DrawLevels(); //TP/SL/BE lines + zone
   ChartRedraw();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Panel.Destroy();
   ChartObj.DeleteAll();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
