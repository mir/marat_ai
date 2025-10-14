#!/usr/bin/env -S uv run --script
# /// script
# dependencies = []
# requires-python = ">=3.12"
# ///

"""
Transfer markdown files from claude_marat_ai to opencode folders,
removing the preamble (YAML frontmatter) from each file.
"""

import re
from pathlib import Path


def remove_preamble(content: str) -> str:
    """
    Remove YAML frontmatter (preamble) from markdown content.

    Preamble is defined as content between --- markers at the start of the file.
    Returns the content after the closing --- marker.
    """
    # Match YAML frontmatter: --- at start, content, then ---
    pattern = r'^---\s*\n.*?\n---\s*\n'
    result = re.sub(pattern, '', content, flags=re.DOTALL)
    return result


def get_target_path(source_path: Path, source_root: Path, target_root: Path) -> Path:
    """
    Convert source path to target path, mapping folder names:
    - agents -> agent
    - commands -> command
    """
    relative_path = source_path.relative_to(source_root)
    parts = list(relative_path.parts)

    # Map folder names
    if parts[0] == 'agents':
        parts[0] = 'agent'
    elif parts[0] == 'commands':
        parts[0] = 'command'

    return target_root / Path(*parts)


def transfer_files(source_root: Path, target_root: Path):
    """
    Transfer all .md files from source to target, removing preambles.
    """
    if not source_root.exists():
        print(f"Error: Source directory does not exist: {source_root}")
        return

    if not target_root.exists():
        print(f"Error: Target directory does not exist: {target_root}")
        return

    # Find all .md files in source
    md_files = list(source_root.rglob("*.md"))

    if not md_files:
        print(f"No .md files found in {source_root}")
        return

    print(f"Found {len(md_files)} markdown files to transfer\n")

    for source_file in md_files:
        # Read source file
        try:
            content = source_file.read_text(encoding='utf-8')
        except Exception as e:
            print(f"✗ Error reading {source_file}: {e}")
            continue

        # Remove preamble
        content_without_preamble = remove_preamble(content)

        # Get target path
        target_file = get_target_path(source_file, source_root, target_root)

        # Ensure target directory exists
        target_file.parent.mkdir(parents=True, exist_ok=True)

        # get target file preamble
        target_preamble = ""
        if target_file.exists():
            try:
                target_content = target_file.read_text(encoding='utf-8')
                target_preamble_match = re.match(r'^(---\s*\n.*?\n---\s*\n)', target_content, flags=re.DOTALL)
                if target_preamble_match:
                    target_preamble = target_preamble_match.group(1)
                    content_without_preamble = target_preamble + content_without_preamble
            except Exception as e:
                print(f"✗ Error reading {target_file} for preamble: {e}")
                # If error reading target file, proceed without adding preamble
        
        # Write to target file with target preamble if exists
        try:
            target_file.write_text(content_without_preamble, encoding='utf-8')
            print(f"✓ Transferred {source_file} to {target_file}") 
        except Exception as e:
            print(f"✗ Error writing {target_file}: {e}")


def main():
    # Get script directory (project root)
    project_root = Path(__file__).parent

    source_root = project_root / "claude_marat_ai"
    target_root = project_root / "opencode"

    print("=" * 60)
    print("Transferring files from claude_marat_ai to opencode")
    print("=" * 60)
    print(f"Source: {source_root}")
    print(f"Target: {target_root}")
    print("=" * 60)
    print()

    transfer_files(source_root, target_root)

    print()
    print("=" * 60)
    print("Transfer complete!")
    print("=" * 60)


if __name__ == "__main__":
    main()
