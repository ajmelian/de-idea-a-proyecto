# Criterios de ingeniería, pruebas y seguridad

Usar al elegir stack, definir NFR, implementar tareas, verificar o auditar código. Respetar primero las dependencias y convenciones aprobadas por el repositorio; no imponer una migración.

## Arquitectura y API

- Priorizar simplicidad y límites explícitos: responsabilidades claras, inyección de dependencias si procede, principios SOLID, arquitectura hexagonal/limpia solo cuando aporten valor verificable.
- Para APIs: especificar operaciones, esquemas, estados HTTP, errores, autenticación, autorización, idempotencia, versionado, paginación y límites si son relevantes.
- Si el proyecto usa OpenAPI, tratar su contrato como artefacto versionado y verificar conformidad mediante pruebas contractuales cuando sea posible.
- Evitar introducir microservicios, event sourcing o patrones costosos por defecto.
- Diseñar migraciones reversibles, backups y estrategia de recuperación cuando se alteren datos persistentes.

## PHP

- Detectar la versión de PHP y del framework realmente soportadas antes de proponer dependencias o APIs nuevas.
- **CodeIgniter 3.x**: tratarlo como código legado cuando corresponda; analizar compatibilidad y deuda técnica antes de cambios, mantener defensas de CSRF/XSS, validaciones y tests adaptados. No asumir soporte automático de cualquier PHP futuro.
- **CodeIgniter 4 + Shield**: aprovechar autenticación, validación, filtros, sesiones y mecanismos de seguridad documentados por la versión concreta.
- **Laravel**: usar validadores, policies/gates, middleware, Eloquent y mecanismos nativos, según el proyecto.
- Pruebas con PHPUnit o Pest solo si están configuradas/aprobadas. Análisis estático con PHPStan/Psalm, estilo PHPCS/PHP-CS-Fixer, SAST/dependencias según pipeline existente. Evitar alterar el stack de QA sin autorización.
- Mantener PHPDoc útil para APIs públicas, tipos complejos y elementos no obvios; tipado estricto cuando la base del proyecto lo permita.

## Java

- Java 21 y Spring Boot 3 son opciones de referencia cuando no existe stack fijado, no un mandato de migración.
- Separar controlador, dominio, persistencia e integraciones conforme a decisiones del proyecto; usar validación declarativa, seguridad en endpoint y servicio cuando corresponda.
- Probar con JUnit 5, pruebas de integración y contractuales según dependencias reales. Maven/Gradle y herramientas de calidad se obtienen del repositorio.

## Seguridad y privacidad

- Aplicar controles OWASP pertinentes: autenticación, autorización por operación y objeto, validación de entrada, consultas parametrizadas, control de sesiones, CSRF si procede, cabeceras y CORS restrictivos, registro de incidentes, rate limits y protección de secretos.
- No leer ni mostrar secretos innecesariamente, no incorporar credenciales en documentación, fixtures o commits. Usar `.env.example` sin valores sensibles, cuando corresponda.
- Datos personales: minimización, finalidad, base jurídica según el contexto, retención, derechos de acceso/borrado, cifrado adecuado y prevención de fugas de información. No afirmar conformidad RGPD/eIDAS sin evaluación y evidencias.
- SaaS multi-tenant: prueba explícita de aislamiento entre tenants, autorización en cada acceso por ID, no confiar solo en identificadores del navegador, separación de almacenamiento/cachés/colas/búsquedas y auditoría de operaciones sensibles.
- Integraciones externas: timeouts, reintentos acotados, idempotencia, validación de webhooks, segregación de credenciales y estados de fallo documentados.
- Seguridad en pipeline: análisis SAST y dependencias, detección de secretos, revisión de permisos, DAST/ZAP únicamente en un entorno autorizado y aislado cuando aplique.

## TDD y verificación

1. Elegir escenario observable y preparar una prueba negativa o positiva.
2. Ejecutar **rojo** y comprobar que falla por el motivo previsto (no por un error de infraestructura sin relación).
3. Implementar lo mínimo; ejecutar **verde**.
4. Refactorizar; volver a ejecutar pruebas relevantes y regresión.
5. Ejecutar linters/análisis estático, contrato, integraciones, seguridad y rendimiento en función del riesgo y de la infraestructura disponible.
6. Guardar comandos y resultados reales; distinguir bloqueos del entorno de fallos funcionales.

No eliminar pruebas, relajar assertions o suprimir análisis para obtener verde. No afirmar cobertura, conformidad OWASP ni tiempos de respuesta sin medición.

## No funcionales

Documentar métricas de aceptación donde sean materiales: disponibilidad, RTO/RPO, latencia percentil y carga, accesibilidad (WCAG aplicable), retención, observabilidad y trazas, i18n y recuperación. No elegir objetivos numéricos arbitrarios y presentarlos como compromisos confirmados.
