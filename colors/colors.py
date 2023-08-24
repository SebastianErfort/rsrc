#!/usr/bin/env python3

import yaml
import json
import argparse
import yamllint

argparser = argparse.ArgumentParser(
        description='Select a single color or a palette and export it '
                    'to the desired file type')
argparser.add_argument(
        '-s', '--colorspace', dest='colorspace', default='rgb',
        help='Color space', action='store_true')
argparser.add_argument(
        '-p', '--palette', dest='palette', help='Color palette',
        action='store_true')
argparser.add_argument(
        '-a', '--add', dest='add', default='{}', help='Add color(s)')
# , choices=['rgb', 'hex'] # that error'd
args = argparser.parse_args()


def colors_load():
    with open('colors.yml', 'r') as file:
        return yaml.safe_load(file)


def colors_save(colors):
    with open('colors.yml', 'w') as file:
        yaml.dump(colors, file)


def main():
    print('args: ', args)
    colors = colors_load()

    if args.palette and args.palette in colors['palettes']:
        palette = colors['palettes'][args.palette]
    elif args.add:
        colors['colors'].update(yaml.safe_load(args.add))
        # TODO Lint before saving, remove duplicates
        colors_save(colors)


if __name__ == '__main__':
    main()
