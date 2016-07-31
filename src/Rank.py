importance=[]
#This is a ranker based on three criteria: the frequency of the query as a whole, the frequency of both words, and the frequency of each
#individual word. 
def Parse(directory, query):
    freqAllWords = 0
    freqOverall = 0
    counter = 0
    freqEachWord=[]
    file = open(directory, 'r')
    words = query.split()
    for line in file:
        for word in words:
            if word in line:
                freqAllWords += 1
        if query in line:
            freqOverall+=1
    importance.append(freqOverall)
    importance.append(freqAllWords)
def Parse2(directory,query):
    counter=0
    freqEachWord = []
    file=open(directory, 'r')
    words = query.split()
    for word in words:
        counter+=1
    for line in file:
        for i in range(0, counter):
            freqEachWord.append(0)
            if words[i] in line:
                freqEachWord[i]+=1
    freqEachWord=freqEachWord[0:counter]
    importance.append(freqEachWord)

Parse("/home/murad/textfile", "report cost")
Parse2("/home/murad/textfile", "report cost")
print (importance)