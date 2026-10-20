# Changelog

Todos los cambios relevantes de este proyecto se documentan aquí. El formato
sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y el
versionado [SemVer](https://semver.org/lang/es/).

## [1.0.0] - 2026-10-20

### Añadido

- Skill `de-idea-a-proyecto` con contrato de proceso y modos explícitos:
  `EXPLORAR`, `DOCUMENTAR`, `IMPLEMENTAR`, `VERIFICAR` y `CERRAR`.
- Flujo SDD con puertas D0, D1/DoR, D2/DoS y D3/DoD.
- Referencias de flujo OpenSpec, trazabilidad, OpenCode v2, calidad/seguridad y
  ejemplos de invocación.
- Script `scripts/preflight.sh` de diagnóstico no destructivo del proyecto.
- Script `scripts/validate.sh` y workflow de CI para validar el paquete.
- Guía de instalación para la CLI de skills.sh y para OpenCode v2.
- README bilingüe (español e inglés), licencia MIT y política de seguridad.

### Corregido

- Identificador unificado como `de-idea-a-proyecto` en todas las referencias e
  instrucciones de invocación.
- Eliminados los artefactos de desarrollo (`logs/`) del paquete publicable.
