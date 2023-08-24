---
author:
- The Author
affiliation: Die Firma
date: \today
title: Much Left Untold
subtitle: Some Been Unfold
header-includes:
    - '\newcommand{\projectNumberCode}{CODE }'
    - '\newcommand{\projectName}{Project Name }'
    - '\newcommand{\coreSystemName}{Core Name }'
    - '\newcommand{\bt}[1]{\fcolorbox{gray}{lightgray}{#1}}'
    - '\usepackage{fontawesome}'
    - '\usepackage{tocloft}'
    - '\usepackage{graphicx}'
    - '\usepackage{hyperref}'
    - '\usepackage{float}'
    - '\usepackage{glossaries}'
    - '\setglossarystyle{altlistgroup}'
    - '\usepackage{xparse}'
    - '\usepackage{lipsum}'
documentclass: article
fontsize: 10pt
secnumdepth: 4
classoptions:
    - a4paper
    - portrait
geometry:
- top=2cm
- left=1cm
- right=1cm
- bottom=2cm
linkcolor: Blue
numbersections: true
mainfont: Arial.ttf <!-- Doesn't seem to do anything -->
---

\pagebreak

\tableofcontents

\setcounter{table}{0}

\listoftables

\pagebreak

# Introduction

## Purpose

\lipsum[1-2]
