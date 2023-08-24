# Proofread your Documents
# pip install language-tool-python
import language_tool_python as ltp

def Proofread():
    checker = ltp.LanguageTool('en-US')
    text = 'A quick broun fox jumpps over a a little lazy dog.'
    correction = checker.correct(text)
    print("Your Original Text:", text)
    print("Corrected Text:", correction)

Proofread()
