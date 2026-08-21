Я настраиваю Neovim как основную IDE для разработки и хочу постепенно улучшить окружение, при этом понимать, что именно делает каждая настройка и плагин.

Моя версия:
- Neovim v0.12.2
- macOS
- конфиг: ~/.config/nvim
- использую lazy.nvim
- предпочитаю не создавать конфиг с нуля, а развивать существующий

Текущая структура:

~/.config/nvim/
├── init.lua
├── lazy-lock.json
└── lua
    ├── base
    │   ├── git_permalink.lua
    │   ├── lsp.lua
    │   ├── other.lua
    │   ├── search.lua
    │   └── tabs.lua
    ├── keys
    │   └── main.lua
    └── plugins
        ├── cmp.lua
        ├── code-companion.lua
        ├── colorscheme.lua
        ├── comment.lua
        ├── diffview.lua
        ├── gitsign.lua
        ├── illuminate.lua
        ├── indent-blankline.lua
        ├── lsp-config.lua
        ├── lualine.lua
        ├── neo-tree.lua
        ├── nvim-autopairs.lua
        ├── surround.lua
        ├── telescope.lua
        ├── todo-comments.lua
        ├── treesitter.lua
        └── trouble.lua

Уже установлены/используются:

- cmp.lua — completion
- code-companion.lua — AI/code assistant
- colorscheme.lua — тема
- comment.lua — комментарии
- diffview.lua — Git diff
- gitsign.lua — Git signs/hunks
- illuminate.lua — подсветка символов
- indent-blankline.lua — indentation guides
- lsp-config.lua — LSP
- lualine.lua — statusline
- neo-tree.lua — файловый менеджер
- nvim-autopairs.lua — автоматические скобки
- surround.lua — работа с окружениями/кавычками/скобками
- telescope.lua — fuzzy finder
- todo-comments.lua — TODO/FIXME/etc.
- treesitter.lua — Treesitter
- trouble.lua — diagnostics

Цель:
Настроить полноценное комфортное development environment на Neovim, примерно уровня современной IDE, но без бессмысленного количества плагинов.

Первоначально были рекомендованы следующие направления:

1. LSP
   - nvim-lspconfig
   - mason.nvim
   - mason-lspconfig.nvim

2. Completion
   - blink.cmp как современная альтернатива nvim-cmp
   - LuaSnip

3. Syntax/code understanding
   - nvim-treesitter

4. Navigation
   - Telescope
   - Oil или существующий Neo-tree
   - Flash.nvim
   - mini.ai
   - which-key.nvim

5. Git
   - Gitsigns
   - Diffview

6. Code quality
   - conform.nvim
   - nvim-lint
   - Trouble
   - todo-comments

7. Editing
   - Comment.nvim
   - nvim-surround
   - mini.pairs / существующий nvim-autopairs
   - LuaSnip

8. UI
   - lualine
   - noice.nvim

Важно:
Не надо автоматически устанавливать всё это. Многие компоненты уже есть. Сначала нужно посмотреть существующую конфигурацию и улучшать её точечно.

План работы:

Этап 1 — разобраться с текущим фундаментом:
- init.lua
- plugins/cmp.lua
- plugins/lsp-config.lua
- base/lsp.lua
- keys/main.lua

Проверить:
- как подключён lazy.nvim;
- как устроена загрузка plugin specs;
- как настроен LSP;
- какие language servers установлены;
- как настроен completion;
- какие keymaps уже существуют;
- нет ли устаревших API;
- нет ли конфликтующих настроек.

Потом:
Этап 2 — LSP + completion + Treesitter
Этап 3 — Telescope / навигация
Этап 4 — Git workflow
Этап 5 — formatting + linting
Этап 6 — улучшение editing workflow
Этап 7 — UI

Принцип обучения:
Не просто давать готовый Lua-конфиг. Объяснять:
- что делает плагин;
- какую проблему решает;
- почему именно этот плагин;
- что делает каждая важная строка конфигурации;
- какие команды и keymaps нужно знать;
- как проверить, что всё работает;
- как диагностировать проблемы.

Предпочтительно идти маленькими шагами:
1. изменить конфиг;
2. запустить Neovim;
3. проверить;
4. объяснить workflow;
5. только потом переходить к следующему компоненту.

Не ломать существующий рабочий конфиг без необходимости.

Так как используется Neovim 0.12.2, ориентироваться на актуальный API Neovim, а не на старые конфигурационные паттерны. В частности, для LSP учитывать современный API `vim.lsp.config()` / `vim.lsp.enable()`.

Первый следующий шаг:
Попросить меня прислать содержимое:
- init.lua
- lua/plugins/cmp.lua
- lua/plugins/lsp-config.lua
- lua/base/lsp.lua
- lua/keys/main.lua

После этого провести аудит существующей конфигурации и продолжить настройку с неё.

## Текущий статус (2026-08-22)

Направление работы: настраивать только Neovim и его плагины. Не добавлять project-specific настройки для QEMU.

### Что уже сделано и проверено

1. LSP и completion
   - `clangd` оставлен с общей настройкой без project-specific аргументов.
   - Исправлена опечатка `cpapbilities` -> `capabilities` в `base/lsp.lua`.
   - `nvim-cmp`: отключён автоматический выбор completion; добавлены `<C-n>` и `<C-p>` для выбора, `<Enter>` подтверждает только явно выбранный вариант.
   - LSP keymaps получили описания. Обычный rename: `<Space>rN`; incremental rename: `<Space>rn`; диагностика текущей строки: `<Space>ld`.

2. Treesitter
   - Parsers уже были установлены для основных используемых языков.
   - В `treesitter.lua` добавлено включение встроенной Treesitter-подсветки на событии `FileType`.
   - Проверка: parser Lua успешно запускается.

3. Навигация
   - Telescope: подключено установленное FZF-расширение, добавлены описания keymaps и picker'ы: `<Space>fo` (recent files), `<Space>fd` (diagnostics), `<Space>fs` (symbols текущего файла).
   - Neo-tree: добавлен явный `setup()`, follow current file, git status, diagnostics и file watcher. `<Space>e` / `<C-n>` переключает дерево, `<Space>er` раскрывает текущий файл.
   - Установлен `folke/flash.nvim`: `<Space>j` — jump, `<Space>J` — Treesitter jump. Стандартные `s`, `f`, `t` и `/` сохранены.
   - Установлен `nvim-mini/mini.ai` на стабильной версии. Настройка оставлена минимальной: `require('mini.ai').setup()`.
   - Установлен `folke/which-key.nvim`: preset `modern`, delay 300 ms, `<Space>?` показывает buffer-local keymaps. Добавлены группы Find, Code, Git, Git hunk, LSP и Toggle.

4. Git
   - Исправлен `gitsigns.nvim`: конфигурация перенесена в `opts.on_attach`, поэтому hunk keymaps buffer-local и работают только в Git-репозитории.
   - Полезные команды: `[c`/`]c` (hunks), `<Space>hp` (preview hunk), `<Space>hs` (stage hunk), `<Space>hr` (reset hunk), `<Space>hb` (blame строки), `<Space>tb` (toggle inline blame).
   - Diffview keymaps: `<Space>gd` (working-tree diff), `<Space>gh` (история текущего файла), `<Space>gH` (история ветки), `<Space>gq` (close).

### Текущий следующий шаг

Этап 5 — formatting и linting. Аудит показал:

- через Mason уже доступны `clang-format`, `black`, `isort`, `shfmt` и `shellcheck`;
- `cmake-format` и `cppcheck` указаны в конфигурации, но пока не устанавливаются автоматически;
- нужно добавить их в `mason-tool-installer`, ручной запуск lint и понятный toggle format-on-save.

Запланированные keymaps:

- `<Space>cf` — форматировать текущий буфер;
- `<Space>cL` — запустить lint текущего буфера;
- `<Space>cF` — включить/выключить format-on-save для текущего буфера;
- `:FormatToggle` — переключить format-on-save глобально;
- `:FormatToggle!` — переключить его только для текущего буфера.

## Актуальное состояние и памятка keymaps (2026-08-22)

Этапы 5–7 завершены. `cmake-format` и `cppcheck` удалены: в текущем реестре Mason таких пакетов нет, поэтому они вызывали ошибки. Format-on-save выключен по умолчанию; ручное форматирование сохранено.

`<Space>` — leader. Клавиши LSP действуют только в буфере с подключённым language server; Gitsigns — только в Git-репозитории.

### Поиск и навигация

| Клавиша | Действие |
| --- | --- |
| `<Space>ff` | Найти файлы |
| `<Space>fG` | Искать текст по проекту (live grep) |
| `<Space>fg` | Искать слово под курсором |
| `<Space>fb` | Открытые буферы |
| `<Space>fo` | Недавние файлы |
| `<Space>fr` | Повторить последний Telescope picker |
| `<Space>fh` | Справка Neovim |
| `<Space>fd` | Diagnostics через Telescope |
| `<Space>fs` | Символы текущего файла |
| `<Space>ft` | TODO/FIXME/HACK по проекту |
| `<Space>e` или `<C-n>` | Открыть/закрыть Neo-tree |
| `<Space>er` | Показать текущий файл в Neo-tree |
| `<Space>j` | Flash jump |
| `<Space>J` | Flash Treesitter jump |
| `<Space>?` | Показать buffer-local keymaps через which-key |

### LSP, completion и качество кода

| Клавиша/команда | Действие |
| --- | --- |
| `K` | Документация для символа под курсором |
| `gd` / `gD` | Перейти к определению / декларации |
| `gi` / `gr` | Реализация / ссылки |
| `<Space>ca` | Code action (normal и visual mode) |
| `<Space>rN` | Обычный LSP rename |
| `<Space>rn` | Incremental rename |
| `<Space>ld` | Diagnostics текущей строки |
| `<Space>cf` | Форматировать буфер вручную |
| `<Space>cL` | Запустить lint текущего буфера |
| `<Space>cF` | Включить/выключить format-on-save для текущего буфера |
| `:FormatToggle` | Включить/выключить format-on-save глобально |
| `:FormatToggle!` | Включить/выключить format-on-save только для текущего буфера |
| `<C-Space>` | Открыть completion menu |
| `<C-n>` / `<C-p>` | Следующий / предыдущий вариант completion |
| `<Enter>` | Подтвердить явно выбранный вариант; иначе новая строка |
| `<C-e>` | Закрыть completion menu |
| `<C-b>` / `<C-f>` | Прокрутить документацию completion |
| `<Tab>` / `<S-Tab>` | Следующий / предыдущий вариант completion или поле LuaSnip; иначе обычный Tab |

### Диагностика и TODO

| Клавиша | Действие |
| --- | --- |
| `<Space>xx` | Все diagnostics в Trouble |
| `<Space>xX` | Diagnostics текущего буфера |
| `<Space>cs` | Символы текущего файла в Trouble |
| `<Space>cl` | Результаты LSP (definitions, references и т. п.) |
| `<Space>xL` | Location List в Trouble |
| `<Space>xQ` | Quickfix List в Trouble |
| `]t` / `[t` | Следующий / предыдущий TODO-комментарий |

### Git

| Клавиша | Действие |
| --- | --- |
| `]c` / `[c` | Следующий / предыдущий Git hunk |
| `<Space>hs` / `<Space>hr` | Stage / reset hunk; в visual mode — выделенные строки |
| `<Space>hd` | Diff текущего файла |
| `<Space>hp` / `<Space>hi` | Preview hunk / inline preview |
| `<Space>hb` / `<Space>hB` | Blame строки / всего файла |
| `<Space>tb` / `<Space>tw` | Переключить inline blame / word diff |
| `<Space>gd` | Открыть Diffview для незакоммиченных изменений |
| `<Space>gh` / `<Space>gH` | История текущего файла / ветки |
| `<Space>gq` | Закрыть Diffview |
| `<Space>gl` | Скопировать permalink текущей строки в Git remote |

### CMake

| Клавиша | Действие |
| --- | --- |
| `<Space>cg` | CMake configure/generate |
| `<Space>cb` | CMake build |
| `<Space>cr` | Запустить цель CMake |
| `<Space>ct` | Запустить CMake tests |

### Editing: встроенные mappings плагинов

- `gcc` — закомментировать/раскомментировать текущую строку; `gc` в visual mode — выделение (`Comment.nvim`).
- `ys{motion}{char}` — добавить окружение, например `ysiw"`; `yss)` — окружить текущую строку скобками (`nvim-surround`).
- `ds{char}` — удалить окружение, например `ds"` или `dsb`; `cs{old}{new}` — заменить, например `cs"'`.
- `S{char}` в visual mode — окружить выделение; `<C-g>s{char}` в insert mode — вставить пару вокруг курсора.
- `mini.ai` добавляет умные text objects: например `vaf` выделяет функцию целиком, `cia` изменяет аргументы вызова.

### Встроенные возможности Vim

- `ma` — поставить метку `a`; `` `a `` — перейти точно к ней; `'a` — к её строке; `:marks` — список меток.
- Глобальные метки: `mA` и `` `A `` работают между файлами.
- Quickfix: `:copen`, `:cclose`, `:cnext`, `:cprev`; Location List: `:lopen`, `:lclose`, `:lnext`, `:lprev`.
