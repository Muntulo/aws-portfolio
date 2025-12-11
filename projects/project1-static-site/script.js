function scrollToSection(sectionId) {
    document.getElementById(sectionId).scrollIntoView({ behavior: 'smooth' });
}

// Optional: Add tooltips on badge hover
document.addEventListener('DOMContentLoaded', function() {
    const badges = document.querySelectorAll('.badge-item img');
    badges.forEach(badge => {
        badge.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.05)';
        });
        badge.addEventListener('mouseout', function() {
            this.style.transform = 'scale(1)';
        });
    });
});