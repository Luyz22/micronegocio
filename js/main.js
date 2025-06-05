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
    // Limpiar mensajes anteriores
    document.getElementById('email-feedback').textContent = '';
    document.getElementById('correo_electronico').classList.remove('input-error');
    
    const datos = {
        nombre_completo: document.getElementById('nombre_completo').value,
        correo_electronico: document.getElementById('correo_electronico').value,
        contrasena: document.getElementById('contrasena').value,
        nombre_negocio: document.getElementById('nombre_negocio').value,
        telefono: document.getElementById('telefono').value
    };

    // Validación de contraseña
    if (!validarContrasenas()) {
        return;
    }

    fetch('../controlador/usuarios.php?accion=registrar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(datos)
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(err => { throw err; });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            mostrarMensajeExito('Registro exitoso. Redirigiendo...');
            setTimeout(() => {
                window.location.href = 'panel.html';
            }, 2000);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        manejarErrorRegistro(error);
    });
}

function manejarErrorRegistro(error) {
    const emailField = document.getElementById('correo_electronico');
    const feedbackElement = document.getElementById('email-feedback');
    
    if (error.error === 'El correo electrónico ya está registrado') {
        // Estilizar el campo de email
        emailField.classList.add('input-error');
        
        // Mostrar mensaje con opciones
        feedbackElement.innerHTML = `
            <div class="alert alert-warning">
                ${error.error}. 
                <a href="#" onclick="mostrarLogin()">Iniciar sesión</a> o 
                <a href="/sistema_gestion/recuperar-contrasena.html">Recuperar contraseña</a>
            </div>
        `;
        
        // Enfocar el campo problemático
        emailField.focus();
    } else {
        mostrarMensajeError(error.error || 'Error en el registro');
    }
}

function mostrarLogin() {
    document.getElementById('login-modal').style.display = 'block';
    document.getElementById('email-feedback').textContent = '';
    document.getElementById('correo_electronico').value = '';
    document.getElementById('correo_electronico').classList.remove('input-error');
}

// Función para validar contraseñas
function validarContrasenas() {
    const contrasena = document.getElementById('contrasena').value;
    const confirmacion = document.getElementById('confirmar_contrasena').value;
    const errorElement = document.getElementById('password-error');
    
    if (contrasena !== confirmacion && confirmacion.length > 0) {
        errorElement.style.display = 'inline';
        return false;
    } else {
        errorElement.style.display = 'none';
        return true;
    }
}

// Event listeners para validación en tiempo real
document.getElementById('confirmar_contrasena').addEventListener('input', validarContrasenas);
document.getElementById('contrasena').addEventListener('input', validarContrasenas);

// Función principal de registro
function registrarUsuario() {
    // Limpiar errores anteriores
    document.querySelectorAll('.error-message').forEach(el => {
        el.textContent = '';
        el.style.display = 'none';
    });

    const datos = {
         nombre_completo: document.getElementById('nombre_completo').value,
        correo_electronico: document.getElementById('correo_registro').value, // Cambiado
        contrasena: document.getElementById('contrasena').value,
        nombre_negocio: document.getElementById('nombre_negocio').value,
        telefono: document.getElementById('telefono').value
    };

    // Validación básica en cliente
    if (!validarContrasenas()) {
        return;
    }

    fetch('/sistema_gestion/controlador/usuarios.php?accion=registrar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(datos)
    })
    .then(async response => {
        const data = await response.json();
        
        if (!response.ok) {
            // Crear un error personalizado con toda la información
            const error = new Error(data.error || 'Error desconocido');
            error.response = data;
            error.status = response.status;
            throw error;
        }
        return data;
    })
    .then(data => {
        if (data.success) {
            mostrarMensajeExito('¡Registro exitoso! Redirigiendo...');
            setTimeout(() => {
                window.location.href = 'panel.html';
            }, 1500);
        }
    })
    .catch(error => {
        console.error('Error completo:', error);
        
        // Mostrar mensaje de error detallado
        const errorMessage = error.response?.error || 
                            error.message || 
                            'Error al conectar con el servidor';
        
        mostrarMensajeError(errorMessage, error.response?.type);
        
        // Manejar casos específicos
        if (error.response?.code === '23000') { // Error de duplicado en SQL
            document.getElementById('correo_electronico').classList.add('input-error');
            document.getElementById('email-feedback').innerHTML = `
                Este correo ya está registrado. 
                <a href="/sistema_gestion/recuperar-contrasena.html?email=${encodeURIComponent(datos.correo_electronico)}">
                    ¿Olvidaste tu contraseña?
                </a>
            `;
        }
    });
}

function mostrarMensajeError(mensaje, tipoError) {
    const errorContainer = document.getElementById('error-container');
    if (!errorContainer) {
        // Crear contenedor si no existe
        const div = document.createElement('div');
        div.id = 'error-container';
        div.className = 'error-container';
        document.querySelector('form').prepend(div);
    }
    
    document.getElementById('error-container').innerHTML = `
        <div class="alert alert-danger ${tipoError || ''}">
            <strong>Error:</strong> ${mensaje}
        </div>
    `;
}