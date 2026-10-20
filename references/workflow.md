# Modelo operativo: de idea a cambio OpenSpec verificable

Leer cuando se necesite planificar un proyecto completo, estructurar un cambio o resolver una transición entre fases.

## Fuentes de verdad (de mayor a menor prioridad)

1. Leyes, obligaciones y contratos aplicables, políticas de seguridad y requisitos expresamente aprobados.
2. Especificación OpenSpec vigente y aceptada, incluyendo escenarios y criterios de aceptación.
3. Contratos de API (por ejemplo OpenAPI), modelo de datos y decisiones arquitectónicas aprobadas.
4. `AGENTS.md` y convenciones de proyecto consistentes con lo anterior.
5. Plan de tarea, incidencias y Jira, si existen.
6. Código actual y pruebas, que pueden mostrar una divergencia con el contrato.

Si hay una contradicción entre niveles, reportarla y solicitar la decisión que corresponda. No reescribir silenciosamente la especificación para justificar el código existente.

## Fases, salidas y puertas

| Fase | Entrada | Salida verificable | Puerta |
|---|---|---|---|
| Explorar (`EXPLORAR`) | Idea, repositorio o documentos | Objetivo, actores, alcance, riesgos, inventario, incógnitas | D0: decisiones críticas |
| Definir (`DOCUMENTAR`) | Contexto validado | Requisitos y arquitectura razonada | Revisión documental |
| OpenSpec (`DOCUMENTAR`) | Cambio solicitado | Artefactos del esquema activo con escenarios | D1/DoR: aceptación |
| Planificar (`DOCUMENTAR`) | Artefactos aceptados | Tareas atómicas, pruebas, matriz de trazabilidad | D2/DoS y autorización de código |
| TDD (`IMPLEMENTAR`) | Una tarea lista | Rojo, verde, refactor y código mínimo | Pruebas y controles |
| Verificar (`VERIFICAR`) | Incremento o documentación | QA, seguridad y evidencia comprobable | Sin bloqueos obligatorios |
| Cerrar (`CERRAR`) | Evidencia y aceptación | Documentación coherente, propuestas de archivo/commit | D3/DoD y autorización específica |

La transición de `DOCUMENTAR` a `IMPLEMENTAR` no es implícita; una petición de generar OpenSpec no autoriza escribir código.

## Inspección segura de OpenSpec (solo lectura)

Ejecutar en la raíz del proyecto, solo cuando la CLI esté disponible y autorizada para uso de lectura:

```bash
openspec --version
openspec list
openspec status --all
```

Para un cambio existente:

```bash
openspec status --change cambio-kebab --json
openspec instructions proposal --change cambio-kebab
openspec validate cambio-kebab
```

Los nombres de artefactos cambian según el esquema. Usar `openspec status` y `openspec instructions` como autoridad sobre dependencias, plantillas y rutas; no crear archivos por intuición si se dispone de esas instrucciones. La validación estructural no sustituye la revisión semántica ni la aceptación humana.

## Operaciones de escritura (requieren autorización DOCUMENTAR o posterior)

- `openspec init`: configura OpenSpec y sus integraciones; no ejecutar sobre un repositorio existente sin revisar las modificaciones.
- `openspec new change <nombre>`: crea un cambio; antes comprobar que no exista otro equivalente.
- `/opsx:propose <descripcion>`: crea o actualiza propuesta y artefactos de planificación, si el flujo está disponible.
- `/opsx:update`: revisa la documentación del cambio, si está disponible.
- `/opsx:apply`: implementa; solo tras D2 y autorización `IMPLEMENTAR`.
- `/opsx:sync` y `/opsx:archive`: modifican el estado de especificaciones/cambios; requieren aceptación para `CERRAR`.

Los comandos `/opsx:*` dependen de la integración y el perfil de OpenSpec instalado (`core` frente a flujos ampliados). Si no existen, seguir la CLI local y las instrucciones del esquema. No instalar ni actualizar herramientas automáticamente. Para generar un artefacto, pedir sus instrucciones con `openspec instructions <artefacto> --change <id>`.

## Contrato mínimo de una propuesta

1. **Contexto y problema**: quién sufre el problema y cómo se observa.
2. **Objetivo y alcance**: entregables, límites del MVP, exclusiones y condicionantes.
3. **Actores y permisos**: rol, operación, dato, aislamiento y errores esperados.
4. **Requisitos**: identificadores estables (`REQ-...`) y escenarios observables.
5. **Diseño**: componentes, persistencia, API, integraciones, transacciones, seguridad y decisiones reversibles.
6. **Plan**: tareas atómicas con pruebas, precedencias, archivos, riesgos y evidencias.
7. **Adopción**: migración, compatibilidad, despliegue y rollback si proceden.
8. **Aceptación**: pruebas, verificaciones, condiciones de inicio y cierre.

En el esquema `spec-driven` habitual, estos contenidos se distribuyen en `proposal.md`, `specs/<capacidad>/spec.md`, `design.md` y `tasks.md`. No imponer esta estructura en un proyecto con esquema personalizado.

## Reglas para conversaciones y sesiones de larga duración

- Reanudar desde el estado real del repositorio, no desde recuerdos no verificados.
- Leer los documentos estrictamente necesarios y conservar IDs estables; evitar volver a cargar todo el proyecto en cada tarea.
- Registrar decisiones con origen y fecha si el proyecto mantiene una bitácora.
- No interpretar 'continúa' como permiso nuevo para implementar si la autorización anterior fue solo documental.
- Ante cambio de alcance: propuesta delta, impacto en pruebas, seguridad y tareas antes de modificar código.
- Auditoría en `Plan`: emitir informe de solo lectura. Edición de documentación autorizada: cambiar a `Build`, con límites documentales explícitos.

## Preguntas bloqueantes

Preguntar cuando falten decisiones sobre: propiedad y acceso a datos, autenticación/autorización, alcance del MVP, contratos externos, normativa, arquitectura irreversible, almacenamiento, despliegue crítico, migraciones destructivas o criterios de aceptación ambiguos. Para detalles no bloqueantes, registrar un supuesto reversible y proponer un valor por defecto.
