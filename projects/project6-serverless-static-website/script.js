// Visitor counter using localStorage (client-side only)
let count = localStorage.getItem('visitCount') || 0;
count++;
localStorage.setItem('visitCount', count);
document.getElementById('visit-count').textContent = count;

// Current year in footer
document.getElementById('current-year').textContent = new Date().getFullYear();