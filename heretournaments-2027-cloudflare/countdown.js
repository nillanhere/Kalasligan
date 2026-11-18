'use strict';
// 15 maj 2027 kl 00:00 i Sverige är 14 maj kl 22:00 UTC (CEST, UTC+2).
const target = Date.parse('2027-05-14T22:00:00Z');
const ids = ['days','hours','minutes','seconds'];
const nodes = ids.map(id => document.getElementById(id));
document.getElementById('year').textContent = new Date().getFullYear();
function updateCountdown(){
  const remaining = Math.max(0, target - Date.now());
  const totalSeconds = Math.floor(remaining / 1000);
  const days = Math.floor(totalSeconds / 86400);
  const hours = Math.floor((totalSeconds % 86400) / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;
  [days,hours,minutes,seconds].forEach((value,index)=>{
    nodes[index].textContent = index === 0 ? String(value) : String(value).padStart(2,'0');
  });
  if (remaining === 0) {
    document.getElementById('timer-note').textContent = '15 maj 2027 är här!';
    clearInterval(interval);
  }
}
const interval = setInterval(updateCountdown, 1000);
updateCountdown();
