# Trade Assistant MT5

Advanced **MetaTrader 5 trade assistant** focused on fast execution, risk management, and **interactive chart control**.

---

## ⚡ Core Idea
Control trades visually.

- Drag TP/SL on chart → updates risk, lot size, R:R  
- Edit panel → updates chart instantly  
- Everything stays in sync in real time  

---

## 🧠 Features

### 🎛 Main Panel (CCanvas)
- Risk % → auto lot size  
- Entry, SL, TP, R:R inputs  
- Buy / Sell / Pending orders  
- Live execution buttons  

### 📊 Chart Interaction (Core)
- TP/SL zones (profit/loss rectangles)  
- Draggable levels (TP, SL, BE)  
- Real-time recalculation:
  - Lot size  
  - Risk %  
  - R:R  
  - P&L  

### 🧩 Tabs
- **Trade** → order entry  
- **Close** → position management  
- **Settings** → presets & risk rules  
- **In Parts** → TP/SL scaling  
- **Trailing** → multiple trailing strategies  
- **Break Even+** → BE + advanced logic  

### 🧱 Context Menu
- Close / Reverse  
- Partial close  
- Breakeven  
- Trailing stop  

---

## 🏗 Architecture
TradeAssistant.mq5
├── Core/
├── UI/
├── Chart/
└── Trading/


- **CCanvas** → UI (panel, buttons)  
- **MT5 Objects** → chart (lines, zones)  

---

## 🔥 Core Mechanic
Chart Drag → Recalculate → Update Panel
Panel Input → Recalculate → Update Chart


---

## 🚧 Roadmap

- [ ] Panel + basic orders  
- [ ] Drag system + sync  
- [ ] Trailing / BE logic  
- [ ] Scheduler + presets  

---

## 💡 Vision

TradingView-like UX with MT5 execution.

---

## ⚠️ Note

Built for traders who understand:
- Risk management  
- Position sizing  
