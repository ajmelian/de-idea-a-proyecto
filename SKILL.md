---
name: de-idea-a-proyecto
description: Convertir ideas, requisitos o proyectos de software en especificaciones OpenSpec y planes de implementación trazables en OpenCode v2. Usar al iniciar proyectos, transformar necesidades en requisitos, diseñar APIs, crear o revisar cambios OpenSpec, auditar documentación, planificar tareas TDD, implementar cambios autorizados y verificar calidad, seguridad y evidencias en PHP o Java. Distinguir planificación de solo lectura, escritura documental y desarrollo; no generar código desde ideas sin especificaciones aprobadas.
license: MIT
---

# De idea a proyecto: OpenCode + OpenSpec + SDD/TDD

## Contrato innegociable

1. Tratar requisitos aprobados y OpenSpec versionado como contrato de desarrollo. No sustituir una decisión humana por una inferencia del agente.
2. Nunca pasar directamente de una idea a código. Obtener primero requisitos verificables, escenarios y autorización para implementar.
3. Interpretar **analizar, revisar, auditar, planificar** como SOLO LECTURA, salvo autorización explícita para escribir archivos. Distinguir la autorización para documentación de la autorización para código.
4. No cambiar código, datos, dependencias, infraestructura, configuración, ramas, commits ni archivos fuera del alcance autorizado. Antes de acciones destructivas, solicitar aprobación específica.
5. Registrar hechos, decisiones aprobadas, hipótesis reversibles, cuestiones bloqueantes y exclusiones. No presentar supuestos como acuerdos.
6. Mantener trazabilidad entre `REQ-ID`, escenarios, `TASK-ID`, pruebas, controles, evidencias y aceptación.
7. No falsificar ejecuciones, resultados, coberturas, auditorías ni validaciones. Si una herramienta falta o falla, señalarlo como **NO VERIFICADO**.
8. Redactar documentación y explicaciones en español de Canarias, claro y profesional. Emplear identificadores y código en inglés, salvo convención del repositorio.

## Elegir el modo antes de actuar

| Modo | Autorización que aporta el usuario | Acciones permitidas | Límite |
|---|---|---|---|
| `EXPLORAR` | Idea, preguntas, análisis o auditoría | Lectura, diagnóstico, informe y propuestas | No escribir archivos en el repositorio |
| `DOCUMENTAR` | Pide explícitamente crear/corregir documentos | Crear o editar solo documentos y artefactos OpenSpec aprobados | No tocar código ejecutable ni ejecutar migraciones |
| `IMPLEMENTAR` | Pide explícitamente implementar y existe una especificación aceptada | TDD en la tarea autorizada, pruebas y documentación asociada | No ampliar el alcance ni saltarse controles |
| `VERIFICAR` | Pide comprobación o revisión | Revisar y ejecutar controles no destructivos autorizados | No corregir archivos sin permiso adicional |
| `CERRAR` | Pide cierre del cambio | Comprobar DoD y preparar evidencias | Archivar, crear commit o publicar SOLO si se autorizan |

Si el modo es incierto, optar por `EXPLORAR` y ofrecer el siguiente paso. La solicitud de usar esta skill no equivale a autorizar cambios en el repositorio.

## OpenCode: elección de agente

- **`Plan`**: análisis, lectura, búsqueda y auditoría. En la configuración predeterminada de OpenCode v2 **no puede escribir** artefactos OpenSpec dentro del proyecto. Presentar propuestas en la respuesta, sin intentar rodear la restricción con comandos shell.
- **`Build`**: usarlo solo tras autorización para `DOCUMENTAR` o `IMPLEMENTAR`. En el primer caso, aplicar la frontera estricta de solo documentación. Las instrucciones de la skill son controles de proceso, NO una barrera técnica de permisos.
- **Subagentes**: asignar revisiones independientes cuando exista un beneficio real, nunca para eludir permisos. Cada subagente puede tener permisos propios; comprobarlos antes de delegar.
- Leer [references/opencode-v2.md](references/opencode-v2.md) al configurar skills, permisos o roles; no mezclar el esquema de configuración de V1 con V2.

## Paso 0. Inspección del repositorio (lectura)

1. Identificar raíz del trabajo, `AGENTS.md`, instrucciones locales, tecnología, pruebas, documentación y estado Git. No modificar un árbol con cambios previos ajenos.
2. Detectar OpenSpec existente: `openspec/config.yaml`, `openspec/changes`, especificaciones, esquema activo y versión de la CLI. No ejecutar `openspec init`, `openspec update` ni crear cambios sin autorización documental.
3. Si la CLI existe, consultar las instrucciones y el estado del cambio por sus comandos de lectura. Respetar rutas y dependencias devueltas por la versión instalada; no asumir que todos los proyectos usan la misma estructura ni un único esquema.
4. Identificar restricciones de cumplimiento, datos sensibles, usuarios, roles, tenants, integraciones y despliegue.
5. Informar: estado observado, fuentes consultadas, contradicciones, lagunas y siguiente acción mínima.

Se puede ejecutar manualmente `scripts/preflight.sh "<ruta-del-proyecto>"` para obtener un diagnóstico no destructivo. No ejecutar scripts desconocidos del repositorio sin inspeccionarlos.

## Flujo SDD con puertas de aprobación

### 1. Descubrimiento y definición

- Establecer problema, objetivo medible, actores, contexto, MVP, fuera de alcance, casos de uso, restricciones, integraciones, datos y amenazas.
- Formular solo preguntas que cambien alcance, arquitectura, seguridad, responsabilidad legal o criterios de aceptación. Agruparlas y proponer alternativas; documentar supuestos reversibles.
- Seleccionar stack a partir del repositorio y las decisiones del proyecto; nunca migrarlo ni actualizarlo implícitamente. Para APIs, preferir contrato OpenAPI si el proyecto lo requiere.
- Describir requisitos funcionales y no funcionales observables: seguridad, privacidad, aislamiento, rendimiento, accesibilidad, internacionalización, observabilidad, recuperación y mantenimiento.

**Puerta D0:** decisiones críticas resueltas o marcadas `BLOQUEANTE`. Sin aceptación, detenerse en la propuesta documental.

### 2. Contrato OpenSpec

- Si OpenSpec ya está configurado, **reutilizar su esquema** y los flujos instalados.
- Si no lo está, proponer su inicialización; ejecutarla únicamente con autorización en `DOCUMENTAR`.
- Para cada cambio, definir propuesta, requisitos y escenarios verificables, diseño, dependencias y tareas conforme a la plantilla que entregue `openspec instructions`. En el esquema habitual `spec-driven` suelen corresponder a `proposal.md`, `specs/`, `design.md`, `tasks.md`, pero no asumir esos nombres si el esquema indica otros.
- Asegurar manejo de migraciones, retrocompatibilidad, rollback, seguridad y aceptación donde corresponda.
- Consultar [references/workflow.md](references/workflow.md) para secuencia, comandos y transiciones.

**Puerta D1 / DoR:** requisitos, escenarios y criterios de aceptación documentados, sin contradicciones bloqueantes y aceptados por el usuario. Documento creado no significa documento aprobado.

### 3. Planificación atómica

- Construir tareas pequeñas y ordenadas por dependencia. Asociar por tarea: IDs de requisito/escenario, prueba roja esperada, superficie de cambio, controles de seguridad, documentación y evidencia.
- Respetar Jira, GitFlow y convenciones de rama/commits **solo cuando existan**; no inventar IDs.
- Usar [references/traceability.md](references/traceability.md) para matriz, DoR/DoS/DoD y formatos de evidencia.

**Puerta D2 / DoS:** tarea lista, entorno y estrategia de pruebas identificados, riesgos acotados y autorización explícita para empezar a implementar. Si solo se autorizaron documentos, PARAR aquí.

### 4. Ejecución TDD (solo modo IMPLEMENTAR)

1. Tomar una única tarea preparada y leer sus requisitos y escenarios.
2. Escribir prueba del comportamiento primero; constatar fallo por el motivo esperado (**rojo**).
3. Implementar el mínimo comportamiento (**verde**) y refactorizar sin romper pruebas.
4. Ejecutar regresión y controles de calidad/seguridad correspondientes al riesgo.
5. Actualizar especificación, documentación, matriz y evidencia en la misma unidad de trabajo.
6. En caso de discrepancia: detener la tarea, exponer contradicción y proponer revisión OpenSpec antes de continuar.

Usar [references/quality-security.md](references/quality-security.md) al decidir stack, pruebas, seguridad, API y controles.

### 5. Verificar y cerrar

- En `VERIFICAR` ejecutar validaciones no destructivas: estructura OpenSpec, pruebas, análisis estático, seguridad, integraciones y trazabilidad según el cambio.
- No declarar una tarea finalizada con verificaciones obligatorias fallidas, pendientes o no ejecutadas. Distinguir `SUPERADO`, `FALLIDO`, `NO EJECUTADO` y `NO APLICA` justificado.
- Mantener documentación viva pertinente (`README.md`, `ARCHITECTURE.md`, `SECURITY.md`, `CONFIGURATION.md`, `INTEGRATIONS.md`, `CHANGELOG.md`, y `VERSION.md` si aplica). Si existe registro de auditoría, respetar su nombre; para uno nuevo, preferir `AUDIT.md`.
- **Puerta D3 / DoD:** criterios demostrados, QA y seguridad sin bloqueos, trazabilidad y evidencia reproducible, coherencia código-especificación-documentación y aceptación. Commits, `git push`, sincronización y archivo de cambios se ejecutan solo con autorización expresa.
- No archivar un cambio OpenSpec antes de su verificación y aceptación.

## Entrega adaptada al modo

Responder con la información necesaria para actuar: estado, evidencia y rutas concretas; decisiones/supuestos/bloqueos; requisitos y artefactos afectados; próximo paso verificable. En `EXPLORAR`, mostrar propuestas sin escribir. En `DOCUMENTAR`, informar archivos realmente creados y controles documentales. En `IMPLEMENTAR`, informar tarea, resultados de TDD y pruebas, diferencias y documentación actualizada. Nunca marcar realizado algo que solo se ha recomendado.

## Recursos de lectura selectiva

- [references/workflow.md](references/workflow.md): proceso por fases y OpenSpec CLI/comandos `opsx`.
- [references/traceability.md](references/traceability.md): registros por tarea, matriz, evidencia y puertas DoR/DoS/DoD.
- [references/opencode-v2.md](references/opencode-v2.md): ubicación de skills, `Plan`/`Build`, permisos V2 y precedencia.
- [references/quality-security.md](references/quality-security.md): estrategias PHP/Java, seguridad, SaaS y QA.
- [references/prompt-examples.md](references/prompt-examples.md): formas de invocación seguras.
