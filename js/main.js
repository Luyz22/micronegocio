// main.js - Archivo principal de JavaScript

// Mobile menu toggle
document.querySelector('.mobile-menu-btn').addEventListener('click', function() {
    document.querySelector('.nav-links').classList.toggle('show');
});

// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            window.scrollTo({
                top: targetElement.offsetTop - 70,
                behavior: 'smooth'
            });
            
            // Close mobile menu if open
            document.querySelector('.nav-links').classList.remove('show');
        }
    });
});

// Highlight active section in navigation
window.addEventListener('scroll', function() {
    const scrollPosition = window.scrollY;
    
    document.querySelectorAll('section').forEach(section => {
        const sectionTop = section.offsetTop - 100;
        const sectionHeight = section.offsetHeight;
        const sectionId = section.getAttribute('id');
        
        if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
            document.querySelectorAll('.nav-links a').forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === `#${sectionId}`) {
                    link.classList.add('active');
                }
            });
        }
    });
});

// Modal de Inicio de Sesión
const modal = document.getElementById('login-modal');
const openModalBtn = document.getElementById('open-login-modal');
const closeModalBtn = document.querySelector('.close-modal');

if (openModalBtn && modal && closeModalBtn) {
    openModalBtn.addEventListener('click', function(e) {
        e.preventDefault();
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    });

    closeModalBtn.addEventListener('click', function() {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    });

    window.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    });
}

// Form submissions
if (document.getElementById('register-form')) {
    document.getElementById('register-form').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('¡Registro exitoso! Pronto nos pondremos en contacto contigo.');
        this.reset();
        window.location.href = '#home';
    });
}

if (document.getElementById('login-form-section')) {
    document.getElementById('login-form-section').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Inicio de sesión exitoso. Redirigiendo al panel de control...');
        this.reset();
    });
}

if (document.getElementById('login-form-modal')) {
    document.getElementById('login-form-modal').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Inicio de sesión exitoso. Redirigiendo al panel de control...');
        this.reset();
        if (modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    });
}

if (document.getElementById('contact-form')) {
    document.getElementById('contact-form').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('¡Mensaje enviado con éxito! Nos pondremos en contacto contigo pronto.');
        this.reset();
    });
}

// Close mobile menu when clicking a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', function() {
        document.querySelector('.nav-links').classList.remove('show');
    });
});

function registrarUsuario() {
    const form = document.getElementById('register-form');

    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const business = document.getElementById('business').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm-password').value;

    if (password !== confirmPassword) {
        alert('Las contraseñas no coinciden');
        return;
    }

    fetch('/controlador/usuario.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            action: 'registrar',
            name,
            email,
            business,
            phone,
            password
        })
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('¡Usuario registrado con éxito!');
            form.reset();
        } else {
            alert('Error: ' + result.message);
        }
    })
    .catch(error => {
        console.error('Error al enviar datos:', error);
        alert('Error en la conexión con el servidor');
    });
}

