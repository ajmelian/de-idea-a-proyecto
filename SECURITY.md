# Política de seguridad

## Alcance

Este repositorio contiene instrucciones de proceso y scripts de diagnóstico
para agentes de código. No es un sandbox de seguridad: las restricciones que
describe la skill son controles de proceso, no barreras técnicas. Las barreras
reales se configuran en los permisos del agente.

## Modelo de amenaza

Los riesgos relevantes son:

- **Prompt injection** desde contenido de repositorios, dependencias, issues o
  documentación analizada.
- **Ampliación de alcance** por parte del agente: escribir código, ejecutar
  migraciones o publicar cambios sin autorización.
- **Exfiltración de secretos** presentes en el proyecto o en el entorno.
- **Ejecución de scripts no revisados** del repositorio analizado.
- **Afirmaciones no verificadas** sobre pruebas, coberturas o auditorías.

## Controles incluidos

- Modo `EXPLORAR` por defecto ante ambigüedad.
- Prohibición de commits, `push`, archivado y acciones destructivas sin
  autorización expresa.
- Prohibición de introducir credenciales, claves o secretos en el código.
- `scripts/preflight.sh` es de solo lectura y no ejecuta scripts del proyecto
  analizado.
- La skill exige distinguir entre resultados superados, fallidos, no ejecutados
  y no aplicables.

## Reportar una vulnerabilidad

No abras un issue público con detalles explotables. Usa
[GitHub Security Advisories](https://github.com/ajmelian/de-idea-a-proyecto/security/advisories/new)
para un reporte privado.

Incluye, si es posible:

- Versión o commit afectado.
- Descripción del impacto.
- Pasos mínimos de reproducción.
- Propuesta de mitigación, si la conoces.

## Tiempos de respuesta

El proyecto es mantenido por voluntarios. Se intentará acusar recibo en un plazo
de siete días y coordinar la divulgación después de disponer de una corrección o
mitigación.
