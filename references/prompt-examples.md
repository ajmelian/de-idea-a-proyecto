# Ejemplos de uso de la skill en OpenCode v2

## Convertir una idea en contrato (sin implementar)

```text
@de-idea-a-proyecto
Actúa en modo EXPLORAR. Analiza esta idea como producto software y prepara
un contrato funcional y técnico para OpenSpec. No escribas ni cambies archivos.
Distingue decisiones, supuestos y bloqueos. Entrega un MVP, NFR y siguientes
pasos documentales.
```

## Auditar un proyecto existente (Plan, lectura)

```text
@de-idea-a-proyecto
Audita este repositorio en modo EXPLORAR, exclusivamente lectura.
Verifica coherencia entre los cambios OpenSpec, sus escenarios y las tareas.
No modifiques documentación, código, configuración ni Git.
Prioriza hallazgos críticos, evidencias por ruta y acciones recomendadas.
```

## Crear o corregir solo OpenSpec (Build autorizado)

```text
@de-idea-a-proyecto
Autorizo el modo DOCUMENTAR para el cambio <ID>.
Usa el esquema OpenSpec instalado; corrige únicamente los archivos
necesarios del cambio y su trazabilidad. No escribas código de aplicación,
no instales dependencias, no cambies Git y no archives el cambio.
Al terminar, indica archivos cambiados y validaciones documentales ejecutadas.
```

## Implementar una tarea aceptada (Build, TDD)

```text
@de-idea-a-proyecto
Autorizo IMPLEMENTAR únicamente la tarea <TASK-ID> del cambio OpenSpec <ID>
que ya ha superado DoR/DoS. Aplica rojo-verde-refactor, controles de seguridad,
pruebas y documentación relacionada. No implementes otras tareas, no hagas
commits ni push, y detente ante contradicciones con la especificación.
```

## Verificar antes de cerrar

```text
@de-idea-a-proyecto
En modo VERIFICAR, compara <ID> con la especificación aceptada.
Comprueba requisitos, evidencias TDD, QA, seguridad y documentación.
No modifiques archivos ni archives el cambio. Emite estado por control:
SUPERADO / FALLIDO / NO EJECUTADO / NO APLICA.
```

Los identificadores `<ID>` y `<TASK-ID>` son marcadores que el usuario debe sustituir por valores reales. Si la petición es solo documental, elegir `Build` con alcance explícito; el agente `Plan` no escribe documentos del repositorio.
