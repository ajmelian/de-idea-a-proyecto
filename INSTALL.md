# Instalación y mantenimiento

Skill `de-idea-a-proyecto` para OpenCode v2 y OpenSpec. Instalarla no modifica
ningún proyecto ni ejecuta cambios: solo añade instrucciones de proceso que el
agente carga cuando se invoca.

## Requisitos

- OpenCode v2 (recomendado) u otro agente compatible con skills.
- OpenSpec CLI, solo si el proyecto lo usa.
- Node.js 22.20 o superior, únicamente si instalas con la CLI de skills.sh.
- `bash` y `git` para la instalación manual y el diagnóstico.

## 1. Instalar con la CLI de skills.sh (recomendado)

```bash
# En el proyecto actual
npx skills add ajmelian/de-idea-a-proyecto

# Global, disponible en todos los proyectos
npx skills add ajmelian/de-idea-a-proyecto -g -a opencode
```

La CLI pregunta el agente y el destino. Para una instalación no interactiva,
indica el agente con `-a opencode`.

## 2. Instalación manual global en OpenCode v2

```bash
mkdir -p "$HOME/.config/opencode/skills"
git clone https://github.com/ajmelian/de-idea-a-proyecto.git \
  "$HOME/.config/opencode/skills/de-idea-a-proyecto"
test -s "$HOME/.config/opencode/skills/de-idea-a-proyecto/SKILL.md" \
  && echo 'Skill instalada'
```

Si ya existe una copia previa, muévela a un respaldo antes de reemplazarla:

```bash
if [ -d "$HOME/.config/opencode/skills/de-idea-a-proyecto" ]; then
  mv "$HOME/.config/opencode/skills/de-idea-a-proyecto" \
     "$HOME/.config/opencode/skills/de-idea-a-proyecto.backup.$(date +%Y%m%d-%H%M%S)"
fi
```

No mezcles una instalación global y una local con el mismo ID si no quieres que
una prevalezca sobre la otra.

## 3. Instalación limitada a un proyecto

```bash
mkdir -p .opencode/skills
git clone https://github.com/ajmelian/de-idea-a-proyecto.git \
  .opencode/skills/de-idea-a-proyecto
```

Usa esta modalidad solo cuando el proyecto necesite una versión fijada o reglas
propias.

## 4. Activar y comprobar

Abre una sesión nueva de OpenCode v2, o reiníciala si no detecta el cambio. En el
proyecto deseado:

```text
@de-idea-a-proyecto
Audita el estado documental de este repositorio y los cambios OpenSpec.
Trabaja exclusivamente en modo EXPLORAR y no modifiques archivos.
```

Diagnóstico independiente de solo lectura:

```bash
bash "$HOME/.config/opencode/skills/de-idea-a-proyecto/scripts/preflight.sh" .
```

El script informa de la configuración local, las versiones de OpenCode y
OpenSpec, los cambios OpenSpec y el estado de Git. No modifica el proyecto.

Si la skill no se anuncia:

1. Comprueba que el directorio y el campo `name` de `SKILL.md` son
   `de-idea-a-proyecto`.
2. Verifica que la descripción YAML es válida y que el cuerpo no está vacío.
3. Revisa la política de la acción `skill` en los permisos de OpenCode v2.
4. Comprueba la precedencia entre `.opencode/skills/` y la instalación global.

Ver [references/opencode-v2.md](references/opencode-v2.md).

## 5. Actualizar

Con la CLI:

```bash
npx skills update de-idea-a-proyecto
```

Con instalación manual:

```bash
git -C "$HOME/.config/opencode/skills/de-idea-a-proyecto" pull --ff-only
```

## 6. Desinstalar

```bash
npx skills remove de-idea-a-proyecto
```

O elimina el directorio instalado:

```bash
rm -rf "$HOME/.config/opencode/skills/de-idea-a-proyecto"
```

## Modos y autorizaciones

- `EXPLORAR`: revisión y propuesta, sin escritura.
- `DOCUMENTAR`: edición documental autorizada en `Build`.
- `IMPLEMENTAR`: código y TDD solo con especificaciones aceptadas.
- `VERIFICAR`: auditoría y controles sin corrección implícita.
- `CERRAR`: verificación DoD y propuesta de cierre; commits y archivo solo con
  permiso específico.

**Importante:** la skill define instrucciones de comportamiento, no un sandbox
de seguridad. Para bloquear realmente herramientas o rutas se deben configurar
los `permissions` del agente. El repositorio no incluye un `opencode.json` que
pueda sobrescribir tu configuración.

## Procedencia y referencias

Adaptación de `de-idea-a-proyecto` que conserva los principios OpenSpec, SDD,
TDD, matriz de trazabilidad, QA y documentación. Las reglas adicionales reflejan
la documentación oficial de OpenCode v2 y el flujo de OpenSpec:

- https://opencode.ai/v2/docs/skills
- https://opencode.ai/v2/docs/permissions
- https://opencode.ai/v2/docs/agents
- https://github.com/Fission-AI/OpenSpec/blob/main/docs/workflows.md

La versión instalada de OpenSpec puede variar. La skill obliga a consultar el
esquema y las instrucciones locales antes de crear artefactos.
