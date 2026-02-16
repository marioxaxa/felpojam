## 📂 Estrutura do Projeto

Este projeto utiliza uma arquitetura **híbrida e modular** no Godot 4.6, focada em organização por funcionalidade e encapsulamento de cenas.

| Pasta | Descrição | Conteúdo Típico |
| :--- | :--- | :--- |
| **`assets/`** | Arquivos brutos e recursos externos que não são cenas. | Músicas (`.ogg`), SFX (`.wav`), fontes e texturas base. |
| **`common/`** | Recursos globais e lógica compartilhada entre cenas. | Componentes (Hitbox/Health), Shaders e Temas (`.tres`). |
| **`core/`** | O "cérebro" e a infraestrutura do jogo. | Scripts de AutoLoad (Singletons), Game Manager e sistemas de Save. |
| **`entities/`** | Objetos dinâmicos e personagens do mundo. | Subpastas para `player` e `enemies` contendo cena + script + arte local. |
| **`levels/`** | Mapas, fases e ambientes do jogo. | Arquivos `.tscn` de fases e recursos de TileSets. |
| **`ui/`** | Elementos de interface de usuário. | Menu principal, HUD, telas de Game Over e inventários. |

---

## 🛠️ Padrões de Nomenclatura

Para garantir a compatibilidade entre diferentes sistemas operacionais (Windows/Linux/Android) e manter o código limpo:

* **Arquivos e Pastas:** `snake_case` (ex: `player_controller.gd`, `main_menu.tscn`).
* **Nomes de Nós (Nodes):** `PascalCase` (ex: `CharacterBody2D`, `PlayerManager`).
* **Variáveis e Funções:** `snake_case` (ex: `var health_points`, `func _take_damage()`).
* **Constantes:** `SCREAMING_SNAKE_CASE` (ex: `const MAX_SPEED = 300.0`).

---
