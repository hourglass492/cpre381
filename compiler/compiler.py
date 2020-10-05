ctl = {
"lw" : 0,
"subi" : 1,
"addi" : 2,
"sw" : 3,
"sla" : 4,
"srl" : 5,
"sra" : 6,
"sll" : 7,
"slt" : 8,
"sub" : 9,
"add" : 10,
"nor" : 11,
"nand" : 12,
"xor" : 13,
"or" : 14,
"and" : 15
}

Itype = ["subi", "addi", "sla", "srl", "sra", "sll"]
Rtype = ["slt" , "sub", "add", "nor", "nand", "xor", "or", "and"]



def toHexAndExtend(decimalNum, numOfByts):
    decimalNum = (16 ** (numOfByts)) + decimalNum

    return hex(decimalNum)[3:]

def toBinaryAndExtend(decimalNum, numOfBits):
    decimalNum = (2 ** (numOfBits)) + decimalNum
    temp = bin(decimalNum)
    temp = bin(decimalNum)[3:]
    return str(bin(decimalNum)[3:])[::1]


def printRType(name, control, destination, reg1, reg2):
    print("--" + name + ", " + str(destination) + ", " + str(reg1) + ", " + str(reg2))
    print("--" + name + "  " + str(reg1) + " and " + str(reg2) + " and store in " + str(destination), end="\n\n")
    print("\t\tctl <= \"" + str(toBinaryAndExtend(control, controlSize))[::-1] + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(int(reg1.replace("$", "")), 5) + "\";")
    print("\t\t rt_s <= \"" + toBinaryAndExtend(int(reg2.replace("$", "")), 5) + "\";")
    print("\t\t rd_s <= \"" + toBinaryAndExtend(int(destination.replace("$", "")), 5) + "\";")



def printIType(name, control, destination , reg1, immedate):

    """Output comments"""
    print("--"+ name +", " + str(destination) + ", " + str(destination) + ", " + str(reg1) + ", " + str(immedate))
    #TODO this is a buggy line
    print("-- "+ name +" " + str(immedate) + " to register " + str(reg1) + " and store in " + str(destination) ,end="\n\n")



    """output actual code"""
    print("\t\tctl <= \"" + str(toBinaryAndExtend(control, controlSize))[::-1] + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(int(reg1.replace("$", "")), 5) + "\";")
    print("\t\t in_immedate_value <=X\"" + toHexAndExtend(int(immedate), 4) + "\";")
    print("\t\t rd_s <= \"" + toBinaryAndExtend(int(destination.replace("$", "")), 5) + "\";")




def parseRW(location):
    array = []
    array.append(location[:location.index("(")].strip("()"))
    array.append(location[location.index("("):].strip("()"))
    return array


#TODO make a common print methiod
def sw(control, regToStore, adderessReg, immedate):

    print("--sw, " + str(regToStore) + ",\t" + str(immedate) + "(" + str(adderessReg) + ")")
    print("-- store " + str(regToStore) + " at memory location " + str(adderessReg) + " plus " + str(immedate), end="\n\n")
    regToStore = int(regToStore.replace("$", "0x"),16)
    adderessReg = int(adderessReg.replace("$", ""))

    """Remove the divided by 4 to make byte addressable"""
    immedate = int(immedate)//4

    print("\t\tctl <= \"" + str(toBinaryAndExtend(control, controlSize))[::-1] + "\";")

    # The register we are storing
    print("\t\t rt_s <= \"" + toBinaryAndExtend(regToStore, 5) + "\";")

    # the register we get the location from
    print("\t\t rs_s <= \"" + toBinaryAndExtend(adderessReg, 5) + "\";")

    # the immideate offset
    print("\t\t in_immedate_value <=X\"" + toHexAndExtend(immedate, 4) + "\";")

#TODO make a common print methiod
def lw(control, loadReg, adderess, immedate):


    print("--lw, " + str(loadReg) + ",\t" + str(immedate) + "(" + str(adderess) + ")")
    print("-- load " + str(immedate) + " plus " + str(adderess) + " from memory into " + str(loadReg), end="\n\n")
    loadReg = int(loadReg.replace("$", "0x"),16)
    adderess = int(adderess.replace("$", ""))


    """Remove the divided by 4 to make byte addressable"""
    immedate = int(immedate)//4

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")

    # The register we are storing
    print("\t\t rd_s <= \"" + toBinaryAndExtend(loadReg, 5) + "\";")

    # the register we get the location from
    print("\t\t rs_s <= \"" + toBinaryAndExtend(adderess, 5) + "\";")


    # the immideate offset
    print("\t\t in_immedate_value <= X\"" + toHexAndExtend(immedate, 4) + "\";")







file = open("./program", "r")
controlSize = 4

"""To fix this remove the /4 in the sw and lw functions"""
print("WARNING: this is currently only 4 byte addressable not byte addresable")



for line in file:
    line = line.replace("," ,"")
    line = line.split()
    i = 0
    while i < len(line):
        if Rtype.__contains__(line[i]):
            printRType(line[i], ctl[line[i]], line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif Itype.__contains__(line[i]):
            printIType(line[i], ctl[line[i]], line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif line[i] == "sw":
            sw(ctl["sw"], line[ i +1],  parseRW(line[ i +2])[1], parseRW(line[ i +2])[0])
            i += 3
        elif line[i] == "lw":
            lw(ctl["lw"], line[ i +1], parseRW(line[ i +2])[1], parseRW(line[ i +2])[0])
            i += 3
        else:
            print("Could not parse " + line[i] + " found at " + str(i))
            i += 1
        print("wait for cCLK_PER;\n" + "\n")
    print(4*"wait for gCLK_HPER;\n"+ "\n")

file.close()
