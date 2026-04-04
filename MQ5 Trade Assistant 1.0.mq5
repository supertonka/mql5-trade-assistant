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
   // Seed initial state
   GlobalState.symbol    = Symbol();
   GlobalState.riskPct   = 1.0;
   GlobalState.lot       = 0.01;
   GlobalState.entryPrice = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
   GlobalState.tpPrice   = GlobalState.entryPrice + 0.00200;
   GlobalState.slPrice   = GlobalState.entryPrice - 0.00100;
   GlobalState.tpPips    = 200;
   GlobalState.slPips    = 100;
   GlobalState.rr        = 2.0;
   GlobalState.bePrice   = GlobalState.entryPrice;
   GlobalState.bePips    = 0;
   GlobalState.magic    = 123456;
   GlobalState.slippage = 10;
   GlobalState.comment  = "TA";

   ChartObj.Init(0);
   Panel.Create(0, "MQL Trade Assistant", 0, 40, 40);
   ChartObj.DrawLevels();
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
// 
   Panel.UpdatePrices();      //refresh bid/ask on buy/sell btns
   Panel.UpdatePnL();         //live P&L update on cahrt label
  }
  
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   // If a chart object was dragged (TP/SL/BE lines) → sync panel
   if(Dragger.OnEvent(id, lparam, dparam, sparam))
     {
      Panel.SyncFromChart();
      return;
     }
   // Otherwise pass event to panel (button clicks, inputs etc)
   Panel.OnEvent(id, lparam, dparam, sparam);
  }
//+------------------------------------------------------------------+
