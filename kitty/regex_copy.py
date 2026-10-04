"""Copy a regex match from the visible kitty screen."""

import os
import re
import shutil
import sys

from kittens.tui.handler import result_handler


def draw_screen_with_prompt(snapshot: str, rows: int) -> str:
    """Render the captured screen above a one-line regex prompt."""
    rows = max(rows, 2)
    lines = re.split(r'\r\n|\r|\n', snapshot)
    output = ['\x1b[?7l\x1b[2J']  # Disable wrapping while restoring screen rows.
    for row, line in enumerate(lines[:rows - 1], 1):
        output.append(f'\x1b[{row};1H\x1b[0m{line}\x1b[0m')
    output.append(f'\x1b[?7h\x1b[{rows};1H\x1b[0m\x1b[2K\x1b[7mRegex:\x1b[0m ')
    return ''.join(output)


def main(args: list[str]) -> str:
    snapshot = sys.stdin.read()
    rows = shutil.get_terminal_size(fallback=(80, 24)).lines
    sys.stdout.write(draw_screen_with_prompt(snapshot, rows))
    sys.stdout.flush()
    try:
        with open(os.ctermid(), 'r', encoding='utf-8') as keyboard:
            return keyboard.readline().rstrip('\r\n')
    except (KeyboardInterrupt, EOFError):
        return ''


@result_handler(type_of_input='screen-ansi')
def handle_result(args, pattern: str, target_window_id: int, boss) -> None:
    window = boss.window_id_map.get(target_window_id)
    if window is not None and pattern:
        boss.run_kitten_with_metadata(
            'hints',
            args=('--type=regex', f'--regex=(?m){pattern}', '--program=@'),
            window=window,
        )
