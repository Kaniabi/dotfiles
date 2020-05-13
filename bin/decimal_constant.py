#!/bin/env python3
import click
import re
"""
Usage:
  ag --py -l "Decimal\(" | xargs /d/Projects/dotfiles/bin/decimal_constant.py | xargs isort -y -a "from uh_core.decimals import DECIMAL_ZERO"
"""

_PATTERNS = [
    (
        r"(?:decimal\.)?Decimal\(['\"]?0\.?0*['\"]?\)",
        "DECIMAL_ZERO"
    ),
]
_PATTERNS = [
    (
        r"@python_2_unicode_compatible",
        "@six.python_2_unicode_compatible"
    ),
]

@click.command()
@click.argument('filenames', nargs=-1)
def main(filenames):
    for i_filename in filenames:

        with open(i_filename, 'r', encoding='UTF-8') as iss:
            content = iss.read()

        result, count = _replace_constants(content)

        if count > 0:
            print(i_filename)
            with open(i_filename, 'w', encoding="UTF-8") as oss:
                oss.write(result)


def _replace_constants(content):
    count = 0
    result = content
    for j_pattern, j_replace in _PATTERNS:
        (result, c) = re.subn(j_pattern, j_replace, result)
        if c > 0:
            count += c
    return result, count


def test_replace_constants():
    assert _replace_constants('This is Decimal(0)') == (
        "This is DECIMAL_ZERO", 1
    )
    assert _replace_constants('This is Decimal("0.0") and Decimal(0)') == (
        "This is DECIMAL_ZERO and DECIMAL_ZERO", 2
    )


if __name__ == "__main__":
    main()
