# Contribuir

Gracias por querer mejorar `de-idea-a-proyecto`. Este repositorio contiene una
skill para agentes y sus referencias, no una aplicación.

## Antes de cambiar nada

1. Abre un issue o una discusión para cambios de comportamiento, nuevas puertas
   de aprobación o modificaciones del contrato de la skill.
2. Para erratas, enlaces rotos o mejoras de redacción, un pull request directo es
   suficiente.
3. No incluyas datos personales, credenciales, rutas privadas ni información de
   proyectos reales en ejemplos o capturas.

## Reglas de contenido

- El campo `name` del frontmatter debe ser `de-idea-a-proyecto` y coincidir con
  el nombre del directorio.
- La descripción debe explicar **qué hace** y **cuándo usarla**, en tercera
  persona y sin depender de contexto externo.
- Mantén las instrucciones en español de Canarias, claras y profesionales.
  Identificadores, comandos y código van en inglés.
- No dupliques contenido entre `SKILL.md` y `references/`: enlaza a la referencia
  correspondiente.
- Cualquier comando nuevo debe ser no destructivo por defecto y estar
  documentado con su autorización requerida.

## Validación

Ejecuta antes de enviar el cambio:

```bash
bash scripts/validate.sh
```

El script comprueba frontmatter, identificador, enlaces relativos, sintaxis de
los scripts y `shellcheck` si está disponible. La CI ejecuta lo mismo en cada
`push` y `pull request`.

## Commits y pull requests

- Un commit por cambio coherente.
- Mensajes en formato [Conventional Commits](https://www.conventionalcommits.org/es/v1.0.0/):
  `feat:`, `fix:`, `docs:`, `test:`, `chore:`.
- Describe en el PR el problema, el cambio y cómo lo verificaste.
- No incrementes la versión ni edites `CHANGELOG.md` salvo que el mantenedor lo
  pida en el PR.
