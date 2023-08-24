# Spell Corrector
# pip install textblob
from textblob import Word

def Spell_Corrector(text):
    w = Word(text)
    checker = w.spellcheck()
    if w == checker[0][0]:
        print(f'Spelling of "{w}" is correct.')
    else:
        print(f'Spelling of "{w}" is incorrect.')
        print(f'Correct spelling of {w}: {checker[0][0]}')

Spell_Corrector("Fliwers") # Flowers
Spell_Corrector("Sleapy") # Sleepy
