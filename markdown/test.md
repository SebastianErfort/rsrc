---
title: LWP5 Autoinstaller aka Unattended Installer
tags:
  - derp
  - schlerp
---
<!-- Front matter should be untouched -->

## TODO

- [ ] shorten this test file to a minimum

## Test

MkDocs markdown renderer

- needs empty line before Markdown list, fix
  - also
    in #fix

    - nested lists

This

- is fine
  - this also

    ```yaml
    Also
    - don't
      touch
          - fenced
    - code blocks
    ```

or | tables
-|-
 | even with empty 1st fields

We're using Markdown extension `mdx_truly_sane_lists` to use an indentation of 2 spaces for lists, compatible with a lot of other Markdown specifications/flavours (CommonMark, GitHub, ...)

- this
  - should not be touched
  - and this
    - this too
    - just like this
- but
  - this needs to be fixed #fix
  - as well as this #fix
  - this is incorrect syntax, let's see what happens #fix
- this too, indentation is wrong as well #fix

- derp
  - schlerp
  - yerp
    - merp
    - nerp
