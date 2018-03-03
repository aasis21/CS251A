import sys
def char_to_num(sym):
    if ord(sym)>=48 and ord(sym)<=57:
        return ord(sym) - 48
    elif ord(sym)>=65 and ord(sym)<=90:
        return ord(sym) - 55
    elif sym=='.':
        return 'D'
    else:
        return 'E'

def power(n,i,t):
    ans=1
    if t=='+':
        for j in range(i):
            ans = ans * n
    if t=='-':
        for j in range(i):
            ans = ans/n
    return ans

def validation(num,base):
    num = num.strip()
    if num[0]=='-':
        num=num[1:]
    if num[0]=='+':
        num=num[1:]
    dot = 0
    for each in num:
        if char_to_num(each)=='E':
            return 0
        if char_to_num(each) == 'D':
            dot = dot + 1
        else:
            if char_to_num(each) >=base:
                return 0

    if dot > 1:
        return 0

    return 1

def convert(num,base):
    num = num.strip()
    if num[0]=='-':
        print('-',end='')
        num=num[1:]

    if num[0]=='+':
        print('+',end='')
        num=num[1:]

    nums = num.split(".")
    before_decimal=0
    ct=0
    for each in nums[0][::-1]:
        before_decimal = char_to_num(each) * (base**ct) + before_decimal
        ct = ct + 1


    if len(nums)==2:
        after_decimal=0
        ct=-1
        for each in nums[1]:
            after_decimal = char_to_num(each) * (base**ct) + after_decimal
            ct = ct - 1
        print(before_decimal + after_decimal)
    else:
        print(before_decimal)


def main():
    num = sys.argv[1]
    str_base = sys.argv[2]
    base=0
    ct=0
    for each in str_base[::-1]:
        base = char_to_num(each) * power(10,ct,'+') + base
        ct = ct + 1

    if(base>36):
        print('Invalid Input')
        return 0
    if(num=='.' or num=='+'):
        print('Invalid Input')
        return 0
    if(num=='-'):
        print('Invalid Input')
        return 0

    if(validation(num,base)):
        convert(num,base)
    else:
        print('Invalid Input')

main()
