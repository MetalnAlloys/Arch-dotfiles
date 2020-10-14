from IPython.terminal.prompts import Prompts, Token
from IPython import get_ipython
from IPython.terminal import interactiveshell
import os

class Myprompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '::: ')]
     # def out_prompt_tokens(self):
          # return [(Token.OutPrompt, ' >> '  )]




c.TerminalInteractiveShell.prompts_class = Myprompt



#class to run some code when the IPython REPL starts
c.InteractiveShell.colors = 'nocolor'
c.InteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.highlighting_style = 'dracula'
c.TerminalInteractiveShell.true_color = True
c.InteractiveShell.separate_in = ''





# Now we start ipython with our configuration

