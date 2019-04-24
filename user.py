import os
class user:

    def __init__(self,x):
        self.name=x
        print("The user:",self.name)

    def gethistory(self,f):
        for r in open("/home/" + str(f).rstrip() + "/.bash_history"):
           commands.append(r.rstrip())


    def printd(self,x):
        print(x)
    def difference(self,list1,list2):
        x=[]
        for i in range(len(list1)):
            for j in range(len(list2)):
               if list2[j] not in  list1[i]:
                   continue
               else:
                   x.append(list1[i])

        return x

def main():
        f = os.popen('whoami').read()
        p = user(f)
        #Getting the bash history
        p.gethistory(f)
        #Printing the history commands
        p.printd(commands)
        others=p.difference(commands,rootcommands)
        p.printd("Executed commands  :"+str(len(commands)))
        p.printd("Non root commands  :"+str(len(others)))

        if (len(others)/len(commands)<1/3):
            p.printd("This is likely to be an advanced user")
        else:
            p.printd("This is likely to be a normal  user")
commands = []
rootcommands =['sudo su','chmod','chown']
others=[]


if __name__=='__main__':
    main()






