# De idea a proyecto — OpenSpec, SDD & TDD for AI coding agents

[![skills.sh](https://skills.sh/b/ajmelian/de-idea-a-proyecto)](https://skills.sh/ajmelian/de-idea-a-proyecto)
[![validate](https://github.com/ajmelian/de-idea-a-proyecto/actions/workflows/validate.yml/badge.svg)](https://github.com/ajmelian/de-idea-a-proyecto/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![OpenCode v2](https://img.shields.io/badge/OpenCode-v2-000000)](https://opencode.ai)
[![OpenSpec](https://img.shields.io/badge/OpenSpec-SDD-4B5563)](https://github.com/Fission-AI/OpenSpec)

**From an idea to an approved OpenSpec contract, test-first tasks and verifiable software changes.**

**De idea a proyecto** es una skill para agentes de programación con IA que convierte ideas o repositorios existentes en requisitos verificables, especificaciones **OpenSpec**, planificación **Spec-Driven Development (SDD)** y tareas **Test-Driven Development (TDD)**. Introduce aprobaciones humanas y trazabilidad para evitar cambios de alcance o implementaciones prematuras.

**English:** An AI coding agent skill for requirements engineering, OpenSpec-driven project planning, TDD implementation and evidence-based verification. Built for **OpenCode v2** (Plan/Build) and portable to other compatible agents. Approval gates are process rules, not a security sandbox.

**Instalación rápida / Quick install:** `npx skills add ajmelian/de-idea-a-proyecto`

[Ver en skills.sh](https://skills.sh/ajmelian/de-idea-a-proyecto) · [Ejemplos de uso / Examples](references/prompt-examples.md) · [Guía de instalación / Install guide](INSTALL.md)

## Casos de uso / Use cases

- **De una idea a OpenSpec / Idea to specification:** descubrir necesidades, delimitar el MVP y generar requisitos y escenarios aceptables antes de escribir código.
- **Auditoría / Repository audit:** revisar un proyecto existente, detectar contradicciones y proponer correcciones sin modificar archivos en modo `EXPLORAR`.
- **Planificación / SDD planning:** descomponer cambios OpenSpec aprobados en tareas atómicas con criterios DoR/DoS y trazabilidad requisito → prueba → evidencia.
- **Implementación y verificación / TDD delivery:** aplicar rojo-verde-refactor únicamente con autorización, ejecutar controles de calidad y seguridad y registrar resultados reales.

La skill aporta un **proceso repetible**, no garantiza ausencia de errores ni sustituye las pruebas, la revisión humana o los permisos del agente.

## Instalación

### Con la CLI de skills.sh (recomendado)

Requiere Node.js 22.20 o superior.

```bash
# Instalar en el proyecto actual
npx skills add ajmelian/de-idea-a-proyecto

# Instalar globalmente (disponible en todos los proyectos)
npx skills add ajmelian/de-idea-a-proyecto -g -a opencode
```

La CLI detecta los agentes instalados y permite elegir destino. Consulta
[todas las opciones](https://github.com/vercel-labs/skills/blob/main/docs/commands.md).

### Instalación manual en OpenCode v2

```bash
git clone https://github.com/ajmelian/de-idea-a-proyecto.git \
  "$HOME/.config/opencode/skills/de-idea-a-proyecto"
```

Para una instalación limitada a un proyecto:

```bash
mkdir -p .opencode/skills
git clone https://github.com/ajmelian/de-idea-a-proyecto.git \
  .opencode/skills/de-idea-a-proyecto
```

Los detalles, actualización y desinstalación están en [INSTALL.md](INSTALL.md).

### Comprobar la instalación

```bash
test -s "$HOME/.config/opencode/skills/de-idea-a-proyecto/SKILL.md" \
  && echo "Skill instalada"

bash "$HOME/.config/opencode/skills/de-idea-a-proyecto/scripts/preflight.sh" .
```

Abre una sesión nueva de OpenCode e invoca la skill:

```text
@de-idea-a-proyecto
Audita este repositorio en modo EXPLORAR. No modifiques archivos.
```

## El problema que resuelve

Los agentes tienden a pasar de una idea a código en el mismo turno: inventan
requisitos, mezclan supuestos con decisiones, amplían el alcance y declaran
«hecho» lo que nunca se verificó. Esta skill impone un contrato de proceso:

- **Modos explícitos** de autorización: explorar, documentar, implementar,
  verificar y cerrar.
- **Puertas de aprobación** (D0, D1/DoR, D2/DoS, D3/DoD) antes de escribir
  documentos o código.
- **Trazabilidad** entre requisitos, escenarios, tareas, pruebas, controles y
  evidencias.
- **TDD** rojo-verde-refactor y verificación honesta: `SUPERADO`, `FALLIDO`,
  `NO EJECUTADO` o `NO APLICA`, nunca una victoria inventada.
- **Seguridad y calidad** como requisitos funcionales, no como un paso final.

## Uso

La skill se activa por mención (`@de-idea-a-proyecto`) o cuando la petición
coincide con su descripción. Ejemplos listos para copiar en
[references/prompt-examples.md](references/prompt-examples.md).

### Modos y autorización

| Modo | Qué autoriza | Qué no permite |
|---|---|---|
| `EXPLORAR` | Leer, diagnosticar, proponer | Escribir en el repositorio |
| `DOCUMENTAR` | Crear o corregir documentos y artefactos OpenSpec | Tocar código ejecutable o migraciones |
| `IMPLEMENTAR` | TDD sobre una tarea con especificación aceptada | Ampliar alcance o saltarse controles |
| `VERIFICAR` | Ejecutar controles no destructivos | Corregir sin permiso adicional |
| `CERRAR` | Comprobar DoD y preparar evidencias | Commit, push o archivo sin autorización expresa |

Si el modo es ambiguo, la skill se detiene en `EXPLORAR`. **Invocar la skill no
autoriza cambios.**

### Flujo

```text
Idea
  ↓
EXPLORAR  → D0: decisiones críticas resueltas
  ↓
DOCUMENTAR → OpenSpec → D1/DoR: requisitos aceptados
  ↓
DOCUMENTAR → plan atómico → D2/DoS: autorización de código
  ↓
IMPLEMENTAR → TDD → controles de calidad y seguridad
  ↓
VERIFICAR → D3/DoD: evidencias reproducibles
  ↓
CERRAR → commit / archivo solo con permiso específico
```

## Qué incluye

```text
de-idea-a-proyecto/
├── SKILL.md                     # Contrato de la skill y flujo con puertas
├── skills.sh.json               # Agrupación y descripción en skills.sh
├── INSTALL.md                   # Instalación, actualización y diagnóstico
├── references/
│   ├── workflow.md              # Fases, CLI OpenSpec y comandos /opsx
│   ├── traceability.md          # Matriz, DoR/DoS/DoD y evidencias
│   ├── opencode-v2.md           # Skills, Plan/Build y permisos V2
│   ├── quality-security.md      # Estrategias PHP/Java, QA y seguridad
│   └── prompt-examples.md       # Invocaciones seguras por modo
├── scripts/
│   ├── preflight.sh             # Diagnóstico de solo lectura del proyecto
│   └── validate.sh              # Validación del propio paquete
├── agents/openai.yaml           # Metadatos de interfaz para Codex/OpenAI
└── .github/workflows/validate.yml
```

## Compatibilidad

- **OpenCode v2**: destino principal. Usa los agentes `Plan` y `Build` y la
  sintaxis de permisos V2. Ver [references/opencode-v2.md](references/opencode-v2.md).
- **OpenSpec**: se adapta al esquema instalado; no impone rutas ni artefactos
  fijos. Consulta `openspec instructions` antes de crear documentos.
- **Otros agentes**: la CLI de skills.sh puede instalar el paquete en Claude
  Code, Codex, Cursor y otros; las referencias específicas de OpenCode pueden
  no aplicar en esos entornos.

## Seguridad

- La skill **no es un sandbox**: son instrucciones de proceso. Para bloquear
  herramientas o rutas hay que configurar `permissions` en el agente.
- Por defecto no escribe archivos, no instala dependencias, no hace commits ni
  `push`, y no ejecuta scripts desconocidos del repositorio.
- No incluye credenciales ni secretos, y prohíbe introducirlos.
- El script `preflight.sh` es de solo lectura y no modifica el proyecto.

Para reportar una vulnerabilidad, consulta [SECURITY.md](SECURITY.md).

## Desarrollo

```bash
bash scripts/validate.sh
```

El mismo script se ejecuta en CI en cada `push` y `pull request`. Consulta
[CONTRIBUTING.md](CONTRIBUTING.md) para el flujo de cambios.

## Registro de cambios

Ver [CHANGELOG.md](CHANGELOG.md).

## Licencia

[MIT](LICENSE) © 2026 Aythami Melián Perdomo.

---

## English summary

**De idea a proyecto** is an agent skill that turns ideas and requirements into
traceable **OpenSpec specifications, TDD plans and verified changes**. It
enforces explicit operating modes (`EXPLORE`, `DOCUMENT`, `IMPLEMENT`,
`VERIFY`, `CLOSE`), human approval gates, requirement-to-evidence traceability,
and honest verification results.

It is built for **OpenCode v2 + OpenSpec**, and can be installed with the
skills.sh CLI:

```bash
npx skills add ajmelian/de-idea-a-proyecto
```

The skill contains process instructions, not a security sandbox. Configure your
agent permissions separately if you need hard technical boundaries. Released
under the MIT license.
