# Dotfiles - Arch Linux + Hyprland

Configuración personal optimizada para **Arch Linux** con el gestor de ventanas **Hyprland**, diseñada para ser minimalista, rápida y estéticamente cuidada (con compatibilidad multiplataforma para macOS y Linux).

![Screenshot](./screenshot.png)

---

## 🛠️ Entorno y Componentes

| Componente | Software | Descripción |
| :--- | :--- | :--- |
| **Window Manager** | [Hyprland](https://hyprland.org/) | Compositor Wayland dinámico, fluido y con soporte de animaciones |
| **Barra de estado** | [Waybar](https://github.com/Alexays/Waybar) | Barra superior con Catppuccin Mocha, módulos simplificados y Nerd Fonts v3 |
| **Fondo de pantalla** | [swaybg](https://github.com/swaywm/swaybg) | Renderizador ultraligero de fondo de pantalla (`~/wallpapers/background.jpg`) |
| **Centro de Notificaciones** | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) | Panel lateral de notificaciones y centro de control rápido |
| **Menú de apagado** | [wlogout](https://github.com/ArtsyMacaw/wlogout) | Interfaz visual para bloqueo, suspensión, reinicio y apagado |
| **Bloqueo y suspensión** | [hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/) & [hypridle](https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/) | Bloqueo de pantalla estético y suspensión por inactividad |
| **Lanzador de aplicaciones** | [wofi](https://hg.sr.ht/~scoopta/wofi) | Menú flotante rápido (`drun`) |
| **Terminales** | [Ghostty](https://ghostty.org/) / [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminales aceleradas por GPU con tema Tokyo Night y fondo negro |
| **Shell** | Zsh + [Starship](https://starship.rs/) | Aliases personalizados (`zshrc.alias.linux`), rutas y prompt moderno |
| **Multiplexor** | [Zellij](https://zellij.dev/) | Gestión de sesiones, pestañas y layouts en terminal |
| **Monitor de recursos** | [btop](https://github.com/aristocratos/btop) | Monitor interactivo de CPU, memoria, discos y procesos |
| **Fuente de iconos** | `ttf-ubuntu-nerd` | Fuente principal para cobertura completa de iconos en Waybar |

---

## ⌨️ Atajos de Teclado Principales (`SUPER` / `Windows`)

- <kbd>SUPER</kbd> + <kbd>Enter</kbd> : Abrir terminal (**Ghostty**)
- <kbd>SUPER</kbd> + <kbd>Espacio</kbd> : Lanzador de aplicaciones (**Wofi**)
- <kbd>SUPER</kbd> + <kbd>Q</kbd> : Cerrar ventana activa
- <kbd>SUPER</kbd> + <kbd>E</kbd> : Explorador de archivos (**Nautilus**)
- <kbd>SUPER</kbd> + <kbd>F</kbd> : Navegador web (**Opera**)
- <kbd>SUPER</kbd> + <kbd>A</kbd> : Alternar centro de notificaciones (**SwayNC**)
- <kbd>SUPER</kbd> + <kbd>X</kbd> : Menú de apagado (**wlogout**)
- <kbd>SUPER</kbd> + <kbd>L</kbd> : Bloquear pantalla (**hyprlock**)
- <kbd>SUPER</kbd> + <kbd>V</kbd> : Alternar ventana flotante
- <kbd>SUPER</kbd> + <kbd>1</kbd> - <kbd>9</kbd> : Cambiar de espacio de trabajo
- <kbd>Impr Pant</kbd> : Captura de pantalla completa (**Hyprshot**)
- <kbd>Shift</kbd> + <kbd>Impr Pant</kbd> : Captura de pantalla por región

---

## 📦 Requisitos Previos (Arch Linux)

Para instalar los paquetes principales utilizados por este setup en una instalación limpia de Arch:

```bash
# Paquetes oficiales
sudo pacman -S hyprland waybar wofi swaybg swaync wlogout hypridle hyprlock \
               ghostty kitty zsh starship btop pipewire wireplumber pavucontrol \
               nautilus ttf-ubuntu-nerd git

# Paquetes recomendados de AUR (usando yay o paru)
yay -S hyprshot bemoji iwgtk
```

---

## 🚀 Proceso de Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/KovacTs/Dotfiles-kovac-1.git ~/Dotfiles
   cd ~/Dotfiles
   ```

2. **Ejecutar el script de instalación:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **¿Qué hace `install.sh`?**
   - Detecta automáticamente el sistema operativo (Linux / macOS).
   - Realiza un respaldo preventivo de cualquier configuración previa en `~/.dotfiles_backup/`.
   - Crea enlaces simbólicos (`symlinks`) automáticos:
     - `hypr/` → `~/.config/hypr`
     - `waybar/` → `~/.config/waybar`
     - `swaync/` → `~/.config/swaync`
     - `wlogout/` → `~/.config/wlogout`
     - `wofi/` → `~/.config/wofi`
     - `ghostty/` → `~/.config/ghostty`
     - `kitty/` → `~/.config/kitty`
     - `btop/` → `~/.config/btop`
     - `zellij/` → `~/.config/zellij`
     - `wallpapers/` → `~/wallpapers`
     - `zsh/zshrc` → `~/.zshrc`
     - `bin/*` → `~/.local/bin/*`

4. **Reiniciar sesión:**
   - Reinicia tu terminal o ejecuta `source ~/.zshrc`.
   - Inicia sesión en tu sesión de Hyprland para cargar todos los servicios y estilos.

---

## 📂 Estructura del Repositorio

```text
.
├── bin/           # Scripts utilitarios (control de brillo, volumen OSD, etc.)
├── btop/          # Temas y configuración del monitor btop
├── ghostty/       # Configuración de Ghostty (Tokyo Night + fondo negro)
├── git/           # Configuración global de Git
├── hypr/          # Hyprland, hypridle y hyprlock
├── kitty/         # Configuración y temas de Kitty
├── swaync/        # Configuración del centro de notificaciones SwayNC
├── wallpapers/    # Fondos de pantalla utilizados por swaybg
├── waybar/        # Barra superior con estilos Catppuccin Mocha y módulos
├── wlogout/       # Layouts y estilos del menú de apagado
├── wofi/          # Estilos del lanzador de aplicaciones Wofi
├── zellij/        # Layouts y temas para Zellij
├── zsh/           # Configuración de Zsh, temas y alias para Linux/macOS
├── install.sh     # Script automatizado de symlinks y respaldos
└── README.md
```
