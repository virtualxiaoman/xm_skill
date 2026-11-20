#!/usr/bin/env python3
"""Copy the portable Vue starter into a new/empty directory without overwrites."""
import argparse
import html
import json
import shutil
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('destination', type=Path)
    parser.add_argument('--title', default='我的技术博客')
    args = parser.parse_args()
    source = Path(__file__).resolve().parents[1] / 'assets' / 'starter'
    destination = args.destination.expanduser().absolute()
    # Reject symlink destinations as well as nonempty directories. No network or installs.
    if destination.is_symlink() or (destination.exists() and (not destination.is_dir() or any(destination.iterdir()))):
        parser.error(f'destination must be nonexistent or an empty directory: {destination}')
    # Also prevent copying into this skill, including a nested directory of the source.
    resolved = destination.resolve()
    skill_root = source.parents[1]
    if resolved == skill_root or skill_root in resolved.parents or resolved in skill_root.parents:
        parser.error('destination must be outside the starter tree and its parent directories')
    shutil.copytree(source, destination, dirs_exist_ok=True, ignore=shutil.ignore_patterns('node_modules', 'dist', '*.local', '.env', '.env.*'))
    site = destination / 'src' / 'site.ts'
    encoded_title = json.dumps(args.title, ensure_ascii=False).replace('\u2028', '\\u2028').replace('\u2029', '\\u2029')
    text = site.read_text(encoding='utf-8').replace("title: '我的技术博客'", 'title: ' + encoded_title, 1)
    site.write_text(text, encoding='utf-8')
    index = destination / 'index.html'
    index.write_text(index.read_text(encoding='utf-8').replace('<title>我的技术博客</title>', '<title>' + html.escape(args.title) + '</title>'), encoding='utf-8')
    print(f'Created {destination}; edit src/site.ts and public/articles, then install dependencies and run npm run build.')


if __name__ == '__main__':
    main()
