from string import ascii_uppercase
import sys

string = sys.argv[1]
base = sys.argv[2]
base = int(base)


#string = raw_input("N=")
#base = int(input("Base="))
n = len(string)

l = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

for c in ascii_uppercase:
    l.append(c)

negative = 0

if string[0] == '-':
    negative = 1
    string = string[1:]

dots = 0

for ch in string:
    if ch is ".":
        dots = dots + 1

if dots > 1:
    #for Python2, remove the parentheses
    print ("Invalid Input")

else:
    if "." in string:
        before_d, after_d = string.split(".")
        digits_after_d = len(after_d)
    else:
        before_d = string
        after_d = []

    p = 0
    ans = 0
    flag = 1

    for k in reversed(before_d):
        if k in l[:base]:
            ans = ((l.index(k))*(base**p)) + ans
        else:
            flag = 0
            #for Python2, remove the parentheses
            print ("Invalid Input")
            break
        p = p + 1

    if flag is 1:
        p = -1
        for k in after_d:
            if k in l[:base]:
                ans = ((l.index(k)) * (base ** p)) + ans
            else:
                flag = 0
                #for Python2, remove the parentheses
                print ("Invalid Input")
                break
            p = p - 1

    if flag is 1:
        if negative is 1:
            #for rounded-off answer to 6 decimal digits (in Python3) :
            print (round(-ans,6))

            #for not rounded-off answer(complete answer) to 6 decimal digits (in Python3) :
            #print(-ans)

            #for python2 :
            #print -ans

        else:
            #for rounded-off answer to 6 decimal digits
            print (round(ans,6))

            #for not rounded-off answer(complete answer) to 6 decimal digits :
            #print(ans)

            #for python2 :
            #print -ans
