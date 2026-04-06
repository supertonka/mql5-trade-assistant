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
bool           g_initialized  =  false;

CPanelMain     Panel;
CChartObjects  ChartObj;
CDragHandler   Dragger;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   // Seed initial state
   //Print("ONINIT REACHED");
   GlobalState.symbol    = Symbol();
   GlobalState.riskPct   = 1.0;
   GlobalState.lot       = 0.01;
   GlobalState.bePips    = 0;
   GlobalState.magic    = 123456;
   GlobalState.slippage = 10;
   GlobalState.comment  = "spook's mql5 trade assistant";
   GlobalState.manualLot = false;
   EventSetMillisecondTimer(100); // refresh every 100ms


   ChartObj.Init(0);
   ChartSetInteger(0,CHART_SHIFT,true);
   Panel.Create(0, "MQL Trade Assistant", 0, 40, 40);
   ChartObj.DrawLevels();
   //Print("Min stops: ", SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL));
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
   EventKillTimer();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      if(!g_initialized)
     {
      double ask   = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
      double bid   = SymbolInfoDouble(Symbol(), SYMBOL_BID);
      double point = SymbolInfoDouble(Symbol(), SYMBOL_POINT);
      int    digits = (int)SymbolInfoInteger(Symbol(), SYMBOL_DIGITS);
      
      // Default 200 pip TP, 100 pip SL — works for any symbol
      double pipSize = (digits == 3 || digits == 5) ? point * 10 : point;
      double tpDist  = 20 * pipSize;
      double slDist  = 10 * pipSize;
      
      GlobalState.entryPrice = ask;
      GlobalState.tpPrice    = ask + tpDist;
      GlobalState.slPrice    = ask - slDist;
      GlobalState.tpPips     = 20;
      GlobalState.slPips     = 10;
      GlobalState.rr         = 2.0;
      GlobalState.bePrice    = bid;
      GlobalState.bePips     = 0;
      
      ChartObj.DrawLevels();
      
      // Correct zones to bid immediately
      ChartObj.UpdateEntryLine(bid);
      ChartObj.UpdateZone(TA_TP_ZONE, bid, GlobalState.tpPrice);
      ChartObj.UpdateZone(TA_SL_ZONE, bid, GlobalState.slPrice);
      
      g_initialized = true;
     } 
     
     // Update entry line to current price
      double ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
      double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
      if(MathAbs(ask - GlobalState.entryPrice) > _Point)
        {
         double tpDist = GlobalState.tpPrice - GlobalState.entryPrice;
         double slDist = GlobalState.entryPrice - GlobalState.slPrice;
         
         GlobalState.entryPrice = ask;
         GlobalState.tpPrice    = ask + tpDist;
         GlobalState.slPrice    = ask - slDist;
         
         ChartObj.UpdateEntryLine(bid);
         ChartObj.UpdateLine(TA_TP_LINE,    GlobalState.tpPrice);
         ChartObj.UpdateLine(TA_SL_LINE,    GlobalState.slPrice);
         ChartObj.UpdateZone(TA_TP_ZONE, bid, GlobalState.tpPrice);
         ChartObj.UpdateZone(TA_SL_ZONE, bid, GlobalState.slPrice);
         ChartObj.UpdateLabels();
        }
     
      Panel.UpdatePrices();      //refresh bid/ask on buy/sell btns
      Panel.UpdatePnL();         //live P&L update on cahrt label
  }
  
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   // If mouse is over panel, block chart interaction
   if(id == CHARTEVENT_MOUSE_MOVE)
     {
      int mx = (int)lparam;
      int my = (int)dparam;
      if(mx >= Panel.GetX() && mx <= Panel.GetX() + Panel.GetW() &&
         my >= Panel.GetY() && my <= Panel.GetY() + Panel.GetH())
        {
         ChartSetInteger(0, CHART_MOUSE_SCROLL, false);
        }
      else
        {
         ChartSetInteger(0, CHART_MOUSE_SCROLL, true);
        }
     }

   Panel.OnEvent(id, lparam, dparam, sparam);
   if(Panel.IsDragging()) return;

   if(Dragger.OnEvent(id, lparam, dparam, sparam))
     {
      Panel.SyncFromChart();
      return;
     }
  }
  
  void OnTimer()
  {
   ChartObj.UpdateLabels();
   Panel.UpdatePrices();
   Panel.UpdatePnL();
   ChartRedraw();
  }
//+------------------------------------------------------------------+
