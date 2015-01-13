from magi.util.agent import DispatchAgent, agentmethod

# the getAgent() method must be defined somewhere for all agents.
# The Magi daemon invokes this mehod to get a reference to an
# agent. It uses this reference to run and interact with an agent
# instance. (The cotangent() call is generally the same for all agent
# implementations: it just returns an instance of the agent.)
def getAgent():
    return FileCreator()

# The FileCreator agent implementation, derived from DispatchAgent.
class FileCreator(DispatchAgent):
    def __init__(self):
        DispatchAgent.__init__(self)
        self.filename = '/tmp/fuckumagi.txt'

    # A single method which creates the file named by self.filename.
    # (The @agentmethod() decorator is not required, but is encouraged.
    #  it does nothing of substance now, but may in the future.)
    @agentmethod()
    def createFile(self, msg):
        '''Create a file on the host.'''
        # open and immediately close the file to create it.
        open(self.filename, 'w').close()
	return True
