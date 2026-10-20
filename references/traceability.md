# Trazabilidad, evidencias y cierre

Leer al crear tareas OpenSpec, diseñar pruebas, auditar incrementos o cerrar cambios.

## Cadena de evidencias

`REQ-ID` -> escenario de especificación -> `TASK-ID` / Jira real (si existe) -> prueba -> cambio de código -> controles de QA/seguridad -> documentos afectados -> aceptación -> commit real (si autorizado).

Mantener referencias bidireccionales. Evitar generar IDs de Jira inexistentes. Si una tarea toca varios requisitos, registrar las relaciones, sin duplicar pruebas artificialmente.

## Matriz de trazabilidad sugerida

| Requisito | Escenario | Tarea | Prueba | Resultado | Evidencia | Estado |
|---|---|---|---|---|---|---|
| `REQ-AUTH-001` | `SCN-AUTH-001` | `TASK-AUTH-001` | `tests/...` | NO EJECUTADO | Pendiente | PREPARADA |

La fila anterior es un ejemplo, no una afirmación sobre un proyecto. Los estados se obtienen exclusivamente de resultados observados. Rutas de evidencias relativas a la raíz del proyecto cuando sea posible.

## Ficha mínima de tarea atómica

- **Identidad**: ID único, título, objetivo verificable y dependencias.
- **Fuente**: requisito y escenario concretos en OpenSpec; enlace Jira solo si real.
- **Alcance**: archivos/componentes previstos, datos y límites prohibidos.
- **Precondiciones**: DoR y DoS, entorno y fixtures.
- **Prueba roja**: comando, nombre del caso y motivo esperado del fallo.
- **Cambio**: implementación mínima, consideraciones de compatibilidad y rollback.
- **Seguridad**: riesgo, control OWASP y escenarios negativos.
- **Pruebas verdes**: comandos exactos, suites, resultado, fecha y limitaciones.
- **Documentación**: ficheros vivos que deben actualizarse, o exclusión razonada.
- **Evidencia y cierre**: rutas/artefactos, DoD, aceptación, hash de commit únicamente si existe realmente.

## Puertas de calidad

### DoR: Definition of Ready

- Requisito aprobado, alcance y escenarios aceptados.
- Dependencias y decisiones críticas resueltas.
- Seguridad y datos considerados; criterios medibles.
- No hay contradicción sin resolver entre contratos.
- Impacto y riesgos conocidos o justificados.

### DoS: Definition of Start

- DoR satisfecha y tarea descompuesta para un ciclo TDD breve.
- Herramientas, pruebas y entorno identificados.
- Cambio y superficie de archivos delimitados.
- Autorización explícita de `IMPLEMENTAR` vigente para el cambio.

### DoD: Definition of Done

- Comportamiento conforme a cada escenario aplicable.
- Secuencia TDD documentada o limitación declarada; pruebas y regresión requeridas en verde.
- Sin bloqueos críticos de calidad/seguridad, o rechazo del cierre.
- Contratos, implementación, documentación y matriz consistentes.
- Evidencias reproducibles, aceptadas y enlazadas a la tarea.
- Cambios ajenos al alcance identificados y no incorporados.

No confundir `NO EJECUTADO` con `SUPERADO`. El porcentaje de cobertura solo se cita si una herramienta lo midió.

## Estados comprobables

- `PROPUESTO`: diseñado, pendiente de aceptación.
- `APROBADO`: decisión humana documentada.
- `PREPARADA`: DoR y DoS satisfechas.
- `EN CURSO`: trabajo autorizado comenzado.
- `BLOQUEADA`: falta decisión o falla control obligatorio.
- `VERIFICADA`: pruebas y QA obligatorios superados.
- `ACEPTADA`: verificación más aceptación del responsable.
- `CERRADA`: proceso de cierre completado y autorizado.

Para controles individuales, utilizar `SUPERADO`, `FALLIDO`, `NO EJECUTADO` y `NO APLICA (motivo)`.

## Documentación viva

- `README.md`: cómo usar, arrancar y conocer el estado real.
- `ARCHITECTURE.md`: decisiones, dependencias, límites y ADR vigentes.
- `SECURITY.md`: amenazas, permisos, secretos y controles.
- `CONFIGURATION.md`: variables no secretas y configuración por entorno.
- `INTEGRATIONS.md`: protocolos, errores, resiliencia, proveedores.
- `CHANGELOG.md`: modificaciones relevantes.
- `VERSION.md`: únicamente cuando forma parte del sistema de versiones.
- Registro de auditoría existente. Si hay que crear uno, usar preferentemente `AUDIT.md` (no `AUDITORY.md`).

No exigir la creación de todos estos documentos a un proyecto pequeño: mantener lo necesario y registrar exclusiones justificadas. Los cambios exclusivamente documentales se verifican documentalmente; no inventar resultados de test de código para cerrarlos.

## Ejemplo de evidencia comprobable

```text
TASK-ID: TASK-API-004
REQ-ID: REQ-API-002
Escenario: SCN-API-002-NEGATIVE
Comando: [comando ejecutado literalmente]
Resultado: [exit code y resumen real]
Archivo de salida: [ruta si realmente se generó]
Estado: SUPERADO | FALLIDO | NO EJECUTADO | NO APLICA
Observaciones: [limitación o decisión, sin rellenar con suposiciones]
```

Para un commit, registrar hash y rama solo después de crearlo de verdad. Nunca ejecutar commit, push, tag o archivo OpenSpec como efecto colateral de `VERIFICAR`.
