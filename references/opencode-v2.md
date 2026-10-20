# OpenCode v2: instalación, permisos y agentes

Usar exclusivamente referencias de OpenCode v2 al trabajar con configuración o selección de agentes. Verificar sintaxis con la versión local antes de editar archivos existentes.

## Carga de Skills

Instalación global recomendada:

```text
~/.config/opencode/skills/de-idea-a-proyecto/SKILL.md
```

Instalación específica en un repositorio:

```text
<raiz-del-proyecto>/.opencode/skills/de-idea-a-proyecto/SKILL.md
```

Cada skill puede incluir `references/` y `scripts/` junto a `SKILL.md`. OpenCode v2 anuncia el ID, nombre y descripción y carga el cuerpo cuando se necesita. Su ID depende del directorio (`de-idea-a-proyecto`), no del nombre visual. Invocar explícitamente escribiendo `@de-idea-a-proyecto` en la petición, o formular una solicitud que coincida con su descripción.

En caso de duplicados, una skill de proyecto `.opencode/skills/` puede prevalecer sobre la global. No añadir copias al proyecto salvo que se necesiten reglas personalizadas.

## Plan y Build: implicaciones

- `Plan`: predeterminado para revisión de solo lectura. OpenCode v2 deniega ediciones del repositorio para este agente, aunque puede mantener sus notas de plan en una carpeta externa propia. No usar shell para evitar su restricción de escritura.
- `Build`: tiene capacidad de modificar archivos. La skill le impone restricciones de proceso, pero esas instrucciones **no garantizan** impedir una acción. Para controles técnicos duros hay que ajustar permisos y revisarlos con el usuario.
- `VERIFICAR`: usar preferentemente `Plan` si solo hay inspección; para ejecutar suites en repositorios donde pueden generar cachés o informes, revisar las implicaciones y autorizaciones.

## Sintaxis V2 (no V1)

En V2 los permisos están en un **array** `permissions`, con objetos `action`, `resource`, `effect`. Por ejemplo, para controlar el acceso a esta skill en una configuración V2:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permissions": [
    { "action": "skill", "resource": "de-idea-a-proyecto", "effect": "allow" }
  ]
}
```

No reemplazar la configuración existente con este ejemplo: incorporar la regla a su array actual solo si es necesaria. V1 utilizaba propiedades distintas (`permission`, `bash`, `task`); copiarlas en V2 puede provocar errores o falsa seguridad.

La aplicación de reglas depende del orden: la **última regla coincidente** prevalece. En V2 se pueden definir reglas específicas bajo `agents.<id>.permissions`; los subagentes mantienen políticas propias. Evitar reglas globales demasiado permisivas, especialmente para shell y acceso a directorios externos.

## Barrera técnica para documentar sin código (opcional)

Para un rol documental estricto se puede crear un subagente con permiso `edit` limitado a rutas OpenSpec y con `shell` denegado. Tiene una contrapartida: tampoco podrá ejecutar la CLI OpenSpec por shell. Por eso es recomendable separar: `Plan` obtiene instrucciones y revisa; un escritor documental con reglas limitadas crea solo los archivos aprobados. Consultar primero la versión de OpenCode y las reglas efectivas de la organización.

No modificar `opencode.json` ni crear agentes por defecto durante la instalación de esta skill. La activación de controles más estrictos corresponde al propietario del entorno.

## Referencias oficiales consultadas

- Skills V2: https://opencode.ai/v2/docs/skills
- Permisos V2: https://opencode.ai/v2/docs/permissions
- Agentes V2: https://opencode.ai/v2/docs/agents

Si cambia el contrato de OpenCode v2, prevalecen las instrucciones locales verificadas y la documentación oficial actualizada. No inventar opciones de CLI.
