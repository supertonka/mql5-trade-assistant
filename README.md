# Trade Assistant MT5

Advanced **MetaTrader 5 trade assistant** focused on fast execution, risk management, and **interactive chart control**.
# MQ5 Trade Assistant — Dev Log

## Day 5 — 05/04/2026

### Completed
- Fixed panel transparency/background issue
- Fixed button text visibility (ARGB color format)
- Fixed color defines (mixed format conflict)
- Input field interactivity (click to activate, type, Enter to commit)
- Numpad support + decimal point key codes
- Manual lot size preserved when dragging SL
- Symbol switching with `< >` arrows (changes chart too)
- Panel draggable without moving chart
- TP/SL/BE lines always selected (no double click needed)
- Entry line tracking current bid price
- TP/SL zones tracking price in real time
- Position label showing P&L for open trades
- Label boxes with colored backgrounds (TP green, SL red)
- Close % reading from input field
- Timer refresh at 100ms for smooth updates
- OBJ_TREND lines (no left extension)
- Default pip-based TP/SL initialization for any symbol
- MessageBox error feedback for failed orders

### Tomorrow (Day 6 — 06/04/2026)
- Label boxes as drag handles replacing line dragging
- Close tab
- Settings tab
- In Parts tab
- Trailing tab
- Break Even+ tab
- Position label context menu
- Trade Time Manager
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
